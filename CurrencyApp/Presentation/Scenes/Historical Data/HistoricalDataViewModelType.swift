//  
//  HistoricalDataViewModelType.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 06/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

/// HistoricalData Input & Output
///
typealias HistoricalDataViewModelType = HistoricalDataViewModelInput & HistoricalDataViewModelOutput

/// HistoricalData ViewModel Input
///
protocol HistoricalDataViewModelInput {
    func fetchHistoricalData()
}

/// HistoricalData ViewModel Output
///
protocol HistoricalDataViewModelOutput {
    var errorMessage: Observable<String> { get }
    var isLoading: Observable<Bool> { get }
    var sectionData: Observable<[SectionData]> { get }
}
