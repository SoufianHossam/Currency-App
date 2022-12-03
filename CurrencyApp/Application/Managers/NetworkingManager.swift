//
//  NetworkingManager.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 03/12/2022.
//

import Foundation

struct NetworkingManager {
    private let config = AppConfigurations()
    
    func setup() {
        let httpHeaders = [
            Constants.apiKey.rawValue: config.apiKey,
        ]
        
        NetworkConfigurations.set(
            baseURI: config.apiBaseURL,
            httpHeaders: httpHeaders
        )
    }
}

private enum Constants: String {
    case apiKey = "apikey"
}
