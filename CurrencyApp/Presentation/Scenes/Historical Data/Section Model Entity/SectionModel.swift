//
//  SectionModel.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 06/12/2022.
//

import RxDataSources

struct SectionData {
    var header: String
    var items: [String]
}

extension SectionData: SectionModelType {
    init(original: SectionData, items: [String]) {
        self = original
        self.items = items
    }
}
