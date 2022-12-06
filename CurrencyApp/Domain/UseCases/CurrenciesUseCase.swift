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
    func fetchHistoricalData(_ input: HistoricalDataInput, completion: @escaping (Result<HistoricalData, Error>) -> Void)
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
        
        if case .to = input.valueSource {
            let updatedInput: Conversion = .init(
                fromCurrency: input.toCurrency,
                toCurrency: input.fromCurrency,
                valueSource: input.valueSource
            )
            cloneInput = updatedInput
        }
        
        currenciesRepo.convertCurrency(cloneInput, completion: completion)
    }
    
    func fetchHistoricalData(_ input: HistoricalDataInput, completion: @escaping (Result<HistoricalData, Error>) -> Void) {
        currenciesRepo.fetchHistoricalData(input, completion: completion)
    }
}
