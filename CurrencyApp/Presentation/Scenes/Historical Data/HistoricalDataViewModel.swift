//  
//  HistoricalDataViewModel.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 06/12/2022.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

// MARK: HistoricalDataViewModel
class HistoricalDataViewModel {
    // Properties
    private let currenciesUseCase: CurrenciesUseCaseProtocol
    private let fromCurrency: String
    private let toCurrency: String
    
    // RX Properties
    private let ratesListRelay: BehaviorRelay<[HistoricalData.Rate]> = .init(value: [])
    private let errorMessageRelay: PublishRelay<String> = .init()
    private let isLoadingRelay: PublishRelay<Bool> = .init()
    private let bag: DisposeBag = .init()
    
    init(
        _ currenciesUseCase: CurrenciesUseCaseProtocol = CurrenciesUseCase(),
        fromCurrency: String,
        toCurrency: String
    ) {
        self.currenciesUseCase = currenciesUseCase
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
    }
}

// MARK: HistoricalDataViewModel
extension HistoricalDataViewModel: HistoricalDataViewModelInput {
    func fetchHistoricalData() {
        isLoadingRelay.accept(true)
        
        let input: HistoricalDataInput = .init(
            fromCurrency: fromCurrency,
            toCurrency: toCurrency,
            date: Date()
        )
        currenciesUseCase.fetchHistoricalData(input) { [isLoadingRelay, ratesListRelay, errorMessageRelay] result in
            isLoadingRelay.accept(false)

            switch result {
            case .success(let history):
                ratesListRelay.accept(history.rates)
                
            case .failure(let failure):
                errorMessageRelay.accept(failure.localizedDescription)
            }
        }
    }
}

// MARK: HistoricalDataViewModelOutput
extension HistoricalDataViewModel: HistoricalDataViewModelOutput {
    var errorMessage: Observable<String> {
        errorMessageRelay.asObservable()
    }
    
    var isLoading: Observable<Bool> {
        isLoadingRelay.asObservable()
    }
    
    var ratesList: Observable<[HistoricalData.Rate]> {
        ratesListRelay.asObservable()
    }
}
