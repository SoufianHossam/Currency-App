//
//  CurrenciesRepository.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import Foundation

struct CurrenciesRepository: CurrenciesRepositoryProtocol {
    let networkClient: NetworkClientProtocol
    
    init(_ networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchCurrencySymbols(completion: @escaping (Result<Currencies, Error>) -> Void) {
        let request = Endpoints.currencySymbols()
        
        networkClient.request(request) { result in
            switch result {
            case .success(let value):
                completion(.success(value.asDomain))
            
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func convertCurrency(_ input: Conversion, completion: @escaping (Result<ConvertedAmount, Error>) -> Void) {
        let request = Endpoints.convert(.init(
            amount: input.amount,
            fromCurrency: input.fromCurrency,
            toCurrency: input.toCurrency
        ))
        
        networkClient.request(request) { result in
            switch result {
            case .success(let value):
                completion(.success(value.asDomain))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
