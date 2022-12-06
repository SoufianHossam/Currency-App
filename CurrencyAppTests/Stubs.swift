//
//  Stubs.swift
//  CurrencyAppTests
//
//  Created by Soufian Hossam on 06/12/2022.
//

import Foundation
@testable import CurrencyApp

extension HistoricalDataInput {
    static func stub(
        fromCurrency: String = "",
        toCurrency: String = "",
        date: Date = .now
    ) -> HistoricalDataInput {
        .init(
            fromCurrency: fromCurrency,
            toCurrency: toCurrency,
            date: date
        )
    }
}

extension Conversion {
    static func stub(
        fromCurrency: String = "",
        toCurrency: String = "",
        amount: ConversionDirection = .from(1)
    ) -> Conversion {
        .init(
            fromCurrency: fromCurrency,
            toCurrency: toCurrency,
            amount: amount
        )
    }
}
