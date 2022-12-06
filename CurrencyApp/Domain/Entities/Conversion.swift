//
//  Conversion.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 05/12/2022.
//

import Foundation

struct Conversion {
    let fromCurrency: String
    let toCurrency: String
    let valueSource: ConversionDirection
}

extension Conversion {
    enum ConversionDirection {
        case from(Double)
        case to(Double)
        
        var value: Double {
            switch self {
            case .from(let value):
                return value
                
            case .to(let value):
                return value
            }
        }
    }
}

struct ConvertedAmount {
    let value: Double
}
