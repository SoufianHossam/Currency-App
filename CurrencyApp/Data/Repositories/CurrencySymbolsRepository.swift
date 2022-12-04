//
//  CurrencySymbolsRepository.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import Foundation

struct CurrencySymbolsRepository: CurrencySymbolsRepositoryProtocol {
    let networkClient: NetworkClientProtocol
    
    init(_ networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchCurrencySymbols(completion: @escaping (Result<Currencies, Error>) -> Void) {
        let urlRequest = Endpoints.currencySymbols()
        
        networkClient.request(urlRequest) { result in
            switch result {
            case .success(let value):
                completion(.success(value.asDomain))
            
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
