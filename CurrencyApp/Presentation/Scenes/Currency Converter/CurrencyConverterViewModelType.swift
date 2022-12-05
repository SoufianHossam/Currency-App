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
    var amountRelay: BehaviorRelay<Conversion.ConversionDirection> { get }
    var fromCurrencyRelay: BehaviorRelay<String> { get }
    var toCurrencyRelay: BehaviorRelay<String> { get }
    
    func fetchCurrencySymbols()
    func swapTheConversion()
}

/// CurrencyConverter ViewModel Output
///
protocol CurrencyConverterViewModelOutput {
    var initialAmount: Double { get }
    var convertedCurrency: Driver<Conversion.ConversionDirection> { get }
    var currencySymbols: Driver<[String]> { get }
    var errorMessage: Signal<String> { get }
    var isLoading: Driver<Bool> { get }
}
