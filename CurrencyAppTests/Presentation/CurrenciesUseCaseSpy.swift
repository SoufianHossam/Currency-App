//
//  CurrenciesUseCaseSpy.swift
//  CurrencyAppTests
//
//  Created by Soufian Hossam on 06/12/2022.
//

@testable import CurrencyApp

class CurrenciesUseCaseMock: CurrenciesUseCaseProtocol {
    var fetchCurrencySymbolsStub: Currencies = .stub()
    var fetchCurrencySymbolsCallCount = 0
    
    var convertCurrencyCallCount = 0
    var convertCurrencyStub: ConvertedAmount = .init(value: 100)
    
    var fetchHistoricalDataCallCount = 0
    var fetchHistoricalDataStub: HistoricalData = .stub()
    
    func fetchCurrencySymbols(completion: @escaping (Result<Currencies, Error>) -> Void) {
        fetchCurrencySymbolsCallCount += 1
        completion(.success(fetchCurrencySymbolsStub))
    }
    
    func convertCurrency(_ input: Conversion, completion: @escaping (Result<ConvertedAmount, Error>) -> Void) {
        convertCurrencyCallCount += 1
        completion(.success(convertCurrencyStub))
    }
    
    func fetchHistoricalData(_ input: HistoricalDataInput, completion: @escaping (Result<HistoricalData, Error>) -> Void) {
        fetchHistoricalDataCallCount += 1
        completion(.success(fetchHistoricalDataStub))
    }
}
