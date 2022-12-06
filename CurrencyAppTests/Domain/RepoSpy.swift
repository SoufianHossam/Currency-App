//
//  RepoSpy.swift
//  CurrencyAppTests
//
//  Created by Soufian Hossam on 06/12/2022.
//

@testable import CurrencyApp

class RepoSpy: CurrenciesRepositoryProtocol {
    var conversionInput: Conversion?
    var fetchCurrencySymbolsCallCount = 0
    var convertCurrencyCallCount = 0
    var fetchHistoricalDataCallCount = 0
    
    func fetchCurrencySymbols(completion: @escaping (Result<Currencies, Error>) -> Void) {
        fetchCurrencySymbolsCallCount += 1
    }
    
    func convertCurrency(_ input: Conversion, completion: @escaping (Result<ConvertedAmount, Error>) -> Void) {
        conversionInput = input
        convertCurrencyCallCount += 1
    }
    
    func fetchHistoricalData(_ input: HistoricalDataInput, completion: @escaping (Result<HistoricalData, Error>) -> Void) {
        fetchHistoricalDataCallCount += 1
    }
}
