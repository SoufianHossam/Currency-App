//
//  HistoricalDataDTO.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 06/12/2022.
//

import Foundation

struct HistoricalDataRequestDTO: Encodable {
    let fromCurrency: String
    let toCurrency: String
    let startDate: String
    let endDate: String
    
    enum CodingKeys: String, CodingKey {
        case fromCurrency = "base"
        case toCurrency = "symbols"
        case startDate = "start_date"
        case endDate = "end_date"
    }
}

struct HistoricalDataResponseDTO: Decodable {
    let rates: [String: [String: Double]]
}

extension HistoricalDataResponseDTO {
    var asDomain: HistoricalData {
        .init(rates: rates.map { dict in
            HistoricalData.Rate(
                date: dict.key,
                values: dict.value.map { $0.value }
            )
        })
    }
}
