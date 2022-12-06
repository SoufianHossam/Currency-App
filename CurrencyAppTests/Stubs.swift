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
        valueSource: ConversionDirection = .from(1)
    ) -> Conversion {
        .init(
            fromCurrency: fromCurrency,
            toCurrency: toCurrency,
            valueSource: valueSource
        )
    }
}

extension Currencies {
    static func stub(list: [String] = ["EGP", "USD", "SAR"]) -> Currencies {
        .init(symbols: list)
    }
}

extension HistoricalData {
    static func stub() -> HistoricalData {
        .init(rates: [.stub(),
                      .stub()])
    }
}

extension HistoricalData.Rate {
    static func stub(
        date: String = "2020-12-10",
        values: [Double] = [1.5, 2.5, 3.5]) -> HistoricalData.Rate {
        .init(
            date: date,
            values: values
        )
    }
}
