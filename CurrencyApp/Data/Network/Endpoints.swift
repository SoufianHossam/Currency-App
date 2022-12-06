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
    
    static func convert(_ input: ConversionDTO) -> Request<ConvertedAmountDTO> {
        .init(path: "convert", parameters: try? input.asDictionary())
    }
    
    static func historicalData(_ input: HistoricalDataRequestDTO) -> Request<HistoricalDataResponseDTO> {
        .init(path: "timeseries", parameters: try? input.asDictionary())
    }
}
