//
//  NetworkConfigurations.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 03/12/2022.
//

import Foundation

enum NetworkConfigurations {
    static var httpHeaders: [String: String]?
    static var baseURI: String!
    
    static func set(
        baseURI: String,
        httpHeaders: [String: String]
    ) {
        self.baseURI = baseURI
        self.httpHeaders = httpHeaders
    }
}

