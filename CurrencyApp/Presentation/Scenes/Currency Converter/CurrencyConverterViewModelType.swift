//  
//  CurrencyConverterViewModelType.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import RxRelay
import RxCocoa
import RxSwift
import Foundation

/// CurrencyConverter Input & Output
///
typealias CurrencyConverterViewModelType = CurrencyConverterViewModelInput & CurrencyConverterViewModelOutput

/// CurrencyConverter ViewModel Input
///
protocol CurrencyConverterViewModelInput {
    var amountRelay: BehaviorRelay<Conversion.ConversionDirection> { get }
    var fromCurrencyRelay: BehaviorRelay<String> { get }
    var toCurrencyRelay: BehaviorRelay<String> { get }
    var detailsRelay: PublishRelay<Void> { get }
    
    func fetchCurrencySymbols()
    func swapTheConversion()
}

/// CurrencyConverter ViewModel Output
///
protocol CurrencyConverterViewModelOutput {
    var convertedCurrency: Observable<Conversion.ConversionDirection> { get }
    var currencySymbols: Observable<[String]> { get }
    var errorMessage: Observable<String> { get }
    var isLoading: Observable<Bool> { get }
    var isCurrenciesSelected: Observable<Bool> { get }
    var selectedCurrenciesDetails: Observable<(String, String)> { get }
}
