//
//  CurrenciesUseCase.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import Foundation

protocol CurrenciesUseCaseProtocol {
    func fetchCurrencySymbols(completion: @escaping (Result<Currencies, Error>) -> Void)
}

struct ListCurrencySymbolsUseCase: CurrenciesUseCaseProtocol {
    private let currencySymbolsRepo: CurrencySymbolsRepositoryProtocol
    
    init(_ currencySymbolsRepo: CurrencySymbolsRepositoryProtocol = CurrencySymbolsRepository()) {
        self.currencySymbolsRepo = currencySymbolsRepo
    }
    
    func fetchCurrencySymbols(completion: @escaping (Result<Currencies, Error>) -> Void) {
        currencySymbolsRepo.fetchCurrencySymbols(completion: completion)
    }
}
