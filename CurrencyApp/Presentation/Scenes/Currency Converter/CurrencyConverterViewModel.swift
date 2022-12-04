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
    
    // RX Public Properties
    var currencySymbols: Driver<[String]> {
        currencySymbolsRelay.asDriver()
    }
    
    var errorMessage: Signal<String> {
        errorMessageRelay.asSignal()
    }
    
    init(_ listCurrencySymbolsUseCase: ListCurrencySymbolsUseCaseProtocol = ListCurrencySymbolsUseCase()) {
        self.listCurrencySymbolsUseCase = listCurrencySymbolsUseCase
    }
}

// MARK: CurrencyConverterViewModel
extension CurrencyConverterViewModel: CurrencyConverterViewModelInput {
    func fetchCurrencySymbols() {
        listCurrencySymbolsUseCase.fetchCurrencySymbols { [currencySymbolsRelay, errorMessageRelay] result in
            switch result {
            case .success(let value):
                currencySymbolsRelay.accept(value.symbols)
                print(value.symbols)
                
            case .failure(let error):
                errorMessageRelay.accept(error.localizedDescription)
            }
        }
    }
}

// MARK: CurrencyConverterViewModelOutput
extension CurrencyConverterViewModel: CurrencyConverterViewModelOutput {
    
}

// MARK: Private Handlers
private extension CurrencyConverterViewModel {
    
}
