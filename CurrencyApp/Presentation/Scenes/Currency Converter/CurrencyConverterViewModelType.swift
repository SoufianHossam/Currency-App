//  
//  CurrencyConverterViewModelType.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import RxRelay
import RxCocoa

/// CurrencyConverter Input & Output
///
typealias CurrencyConverterViewModelType = CurrencyConverterViewModelInput & CurrencyConverterViewModelOutput

/// CurrencyConverter ViewModel Input
///
protocol CurrencyConverterViewModelInput {
    func fetchCurrencySymbols()
}

/// CurrencyConverter ViewModel Output
///
protocol CurrencyConverterViewModelOutput {
    var currencySymbols: Driver<[String]> { get }
    var errorMessage: Signal<String> { get }
}
