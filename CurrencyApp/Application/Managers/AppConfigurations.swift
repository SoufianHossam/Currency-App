//
//  AppConfigurations.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 02/12/2022.
//

import Foundation

final class AppConfigurations {
    // It's better to obfuscate the token using for example: CocoaPods-Keys
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
