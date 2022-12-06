//
//  Date + Extensions.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 06/12/2022.
//

import Foundation

extension Date {
    var asString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    func jumpBack(by days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -days, to: self)!
    }
}
