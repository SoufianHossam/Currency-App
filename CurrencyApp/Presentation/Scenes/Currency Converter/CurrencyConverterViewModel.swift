//  
//  CurrencyConverterViewModel.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import RxRelay
import RxCocoa
import RxSwift

// MARK: CurrencyConverterViewModel
class CurrencyConverterViewModel {
    // Properties
    let currenciesUseCase: CurrenciesUseCaseProtocol
    
    // RX Properties
    private let currencySymbolsRelay: BehaviorRelay<[String]> = .init(value: [])
    private let errorMessageRelay: PublishRelay<String> = .init()
    private let isLoadingRelay: PublishRelay<Bool> = .init()
    private let convertedCurrencyRelay: BehaviorRelay<Conversion.ConversionDirection> = .init(value: .from(0))
    
    let bag: DisposeBag = .init()
    
    lazy var amountRelay: BehaviorRelay<Conversion.ConversionDirection> = .init(value: .from(initialAmount))
    let fromCurrencyRelay: BehaviorRelay<String> = .init(value: "")
    let toCurrencyRelay: BehaviorRelay<String> = .init(value: "")
    
    init(_ currenciesUseCase: CurrenciesUseCaseProtocol = CurrenciesUseCase()) {
        self.currenciesUseCase = currenciesUseCase
        setupBindings()
    }
}

// MARK: CurrencyConverterViewModel
extension CurrencyConverterViewModel: CurrencyConverterViewModelInput {
    func fetchCurrencySymbols() {
        isLoadingRelay.accept(true)
        
        currenciesUseCase.fetchCurrencySymbols { [isLoadingRelay, currencySymbolsRelay, errorMessageRelay] result in
            isLoadingRelay.accept(false)
            
            switch result {
            case .success(let value):
                currencySymbolsRelay.accept(value.symbols.sorted())
                print(value.symbols)
                
            case .failure(let error):
                errorMessageRelay.accept(error.localizedDescription)
            }
        }
    }
    
    func swapTheConversion() {
        var tempCurrency: String = ""
        
        tempCurrency = fromCurrencyRelay.value
        fromCurrencyRelay.accept(toCurrencyRelay.value)
        toCurrencyRelay.accept(tempCurrency)
    }
}

// MARK: CurrencyConverterViewModelOutput
extension CurrencyConverterViewModel: CurrencyConverterViewModelOutput {
    // RX Public Properties
    var currencySymbols: Driver<[String]> {
        currencySymbolsRelay.asDriver()
    }
    
    var errorMessage: Signal<String> {
        errorMessageRelay.asSignal()
    }
    
    var isLoading: Driver<Bool> {
        isLoadingRelay.asDriver(onErrorJustReturn: false)
    }
    
    var convertedCurrency: Driver<Conversion.ConversionDirection> {
        convertedCurrencyRelay.asDriver()
    }
    
    var initialAmount: Double {
        1
    }
}

extension CurrencyConverterViewModel {
    func setupBindings() {
        Observable.combineLatest(
            amountRelay.asObservable(),
            fromCurrencyRelay.asObservable(),
            toCurrencyRelay.asObservable()
        )
        .debounce(.milliseconds(800), scheduler: MainScheduler.instance)
        .filter { amount, from, to in
            amount.value > 0 && !from.isEmpty && !to.isEmpty
        }
        .subscribe { [weak self] amount, from, to in
            let input: Conversion = .init(
                fromCurrency: from,
                toCurrency: to,
                amount: amount
            )
            self?.convert(input)
        }
        .disposed(by: bag)
    }
    
    func convert(_ input: Conversion) {
        isLoadingRelay.accept(true)
        
        currenciesUseCase.convertCurrency(input) { [isLoadingRelay, errorMessageRelay, convertedCurrencyRelay] result in
            isLoadingRelay.accept(false)

            switch result {
            case .success(let value):
                switch input.amount {
                case .from:
                    convertedCurrencyRelay.accept(.from(value.value))
                case .to:
                    convertedCurrencyRelay.accept(.to(value.value))
                }
                
            case .failure(let error):
                errorMessageRelay.accept(error.localizedDescription)
            }
        }
    }
}
