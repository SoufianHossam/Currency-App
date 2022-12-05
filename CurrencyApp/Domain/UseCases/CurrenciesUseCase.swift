//
//  CurrenciesUseCase.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import Foundation

protocol CurrenciesUseCaseProtocol {
    func fetchCurrencySymbols(completion: @escaping (Result<Currencies, Error>) -> Void)
    func convertCurrency(_ input: Conversion, completion: @escaping (Result<ConvertedAmount, Error>) -> Void)
}

struct CurrenciesUseCase: CurrenciesUseCaseProtocol {
    private let currenciesRepo: CurrenciesRepositoryProtocol
    
    init(_ currencySymbolsRepo: CurrenciesRepositoryProtocol = CurrenciesRepository()) {
        self.currenciesRepo = currencySymbolsRepo
    }
    
    func fetchCurrencySymbols(completion: @escaping (Result<Currencies, Error>) -> Void) {
        currenciesRepo.fetchCurrencySymbols(completion: completion)
    }
    
    func convertCurrency(_ input: Conversion, completion: @escaping (Result<ConvertedAmount, Error>) -> Void) {
        var cloneInput: Conversion = input
        
        if case .to = input.amount {
            let updatedInput: Conversion = .init(
                fromCurrency: input.toCurrency,
                toCurrency: input.fromCurrency,
                amount: input.amount
            )
            cloneInput = updatedInput
        }
        
        currenciesRepo.convertCurrency(cloneInput, completion: completion)
    }
}
