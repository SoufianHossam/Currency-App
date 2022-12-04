//
//  ConversionDTO.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 05/12/2022.
//

import Foundation

struct ConversionDTO: Encodable {
    let fromCurrency: String
    let toCurrency: String
    let amount: Double
}

struct ConvertedAmountDTO: Decodable {
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case value = "result"
    }
}

extension ConvertedAmountDTO {
    var asDomain: ConvertedAmount {
        .init(value: value)
    }
}
