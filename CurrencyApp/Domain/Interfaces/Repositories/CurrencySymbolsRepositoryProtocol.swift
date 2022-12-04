//
//  CurrencySymbolsRepository.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import Foundation

protocol CurrencySymbolsRepositoryProtocol {
    func fetchCurrencySymbols(completion: @escaping (Result<Currencies, Error>) -> Void)
    func convertCurrency(_ input: Conversion, completion: @escaping (Result<ConvertedAmount, Error>) -> Void)
}
