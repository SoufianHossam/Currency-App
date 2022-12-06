//
//  HistoricalData.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 06/12/2022.
//

import Foundation

struct HistoricalDataInput {
    let fromCurrency: String
    let toCurrency: String
    let date: Date
}

struct HistoricalData {
    let rates: [Rate]
    
    struct Rate {
        let date: String
        let values: [Double]
    }
}
