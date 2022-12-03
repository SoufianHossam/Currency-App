//
//  CurrenciesDTO.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 03/12/2022.
//

import Foundation

struct CurrenciesDTO: Decodable {
    let symbols: [String: String]
}

extension CurrenciesDTO {
    var asDomain: Currencies {
        .init(symbols: symbols.keys.map(String.init(describing:)))
    }
}
