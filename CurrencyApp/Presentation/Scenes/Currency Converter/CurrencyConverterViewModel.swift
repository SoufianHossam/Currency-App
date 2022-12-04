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
    let listCurrencySymbolsUseCase: ListCurrencySymbolsUseCaseProtocol
    
    // RX Properties
    private let currencySymbolsRelay: BehaviorRelay<[String]> = .init(value: [])
    private let errorMessageRelay: PublishRelay<String> = .init()
    private let isLoadingRelay: PublishRelay<Bool> = .init()
    
    init(_ listCurrencySymbolsUseCase: ListCurrencySymbolsUseCaseProtocol = ListCurrencySymbolsUseCase()) {
        self.listCurrencySymbolsUseCase = listCurrencySymbolsUseCase
    }
}

// MARK: CurrencyConverterViewModel
extension CurrencyConverterViewModel: CurrencyConverterViewModelInput {
    func fetchCurrencySymbols() {
        isLoadingRelay.accept(true)
        
        listCurrencySymbolsUseCase.fetchCurrencySymbols { [isLoadingRelay, currencySymbolsRelay, errorMessageRelay] result in
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
