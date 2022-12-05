//  
//  CurrencyConverterViewModel.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import RxRelay
import RxCocoa

// MARK: CurrencyConverterViewModel
class CurrencyConverterViewModel {
    // Properties
    let currenciesUseCase: CurrenciesUseCaseProtocol
    
    // RX Properties
    private let currencySymbolsRelay: BehaviorRelay<[String]> = .init(value: [])
    private let errorMessageRelay: PublishRelay<String> = .init()
    private let isLoadingRelay: PublishRelay<Bool> = .init()
    
    init(_ currenciesUseCase: CurrenciesUseCaseProtocol = CurrenciesUseCase()) {
        self.currenciesUseCase = currenciesUseCase
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
        isLoadingRelay.accept(true)

        let input: Conversion = .init(
            fromCurrency: "USD",
            toCurrency: "EGP",
            amount: 1
        )
        
        currenciesUseCase.convertCurrency(input) { [isLoadingRelay, errorMessageRelay] result in
            isLoadingRelay.accept(false)

            switch result {
            case .success(let value):
                print(value.value)
                
            case .failure(let error):
                errorMessageRelay.accept(error.localizedDescription)
            }
        }
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
}
