//
//  Endpoints.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 03/12/2022.
//

import Foundation

enum Endpoints {
    static func currencySymbols() -> Request<CurrenciesDTO> {
        .init(path: "symbols")
    }
}
