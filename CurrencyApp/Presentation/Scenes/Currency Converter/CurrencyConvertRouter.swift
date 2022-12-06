//
//  CurrencyConvertRouter.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 06/12/2022.
//

import Foundation
import UIKit

protocol CurrencyConvertRouterProtocol {
    func routeTo(_ listViewController: UIViewController)
    func routeToHistoricalDataScene(fromCurrency: String, toCurrency: String)
}

class CurrencyConvertRouter: CurrencyConvertRouterProtocol {
    weak var viewController: UIViewController?
    
    func routeTo(_ listViewController: UIViewController) {
        viewController?.present(listViewController, animated: true)
    }
    
    func routeToHistoricalDataScene(fromCurrency: String, toCurrency: String) {
        let viewModel = HistoricalDataViewModel(fromCurrency: fromCurrency, toCurrency: toCurrency)
        viewController?.present(HistoricalDataViewController(viewModel: viewModel), animated: true)
    }
}
