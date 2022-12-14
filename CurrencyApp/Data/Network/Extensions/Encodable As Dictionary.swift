//
//  AsDictionary.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 03/12/2022.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
         let encoder = JSONEncoder()
         let data = try encoder.encode(self)
         guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
             throw NSError()
         }
         return dictionary
     }
}
