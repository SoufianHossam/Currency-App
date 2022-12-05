//  
//  CurrencyConverterViewController.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyConverterViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var fromButton: UIButton!
    @IBOutlet private weak var toButton: UIButton!
    @IBOutlet private weak var swapButton: UIButton!
    @IBOutlet private weak var fromTextField: UITextField!
    @IBOutlet private weak var toTextField: UITextField!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    private let viewModel: CurrencyConverterViewModelType
    private let listViewController = ListViewController()
    private let bag: DisposeBag = .init()
    
    // MARK: Init
    init(viewModel: CurrencyConverterViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        
        viewModel.fetchCurrencySymbols()
    }
    
    // MARK: Actions
    @IBAction private func fromButtonAction(_ sender: UIButton) {
        present(listViewController, animated: true)
        
        listViewController.didSelectItem = { [fromButton] item in
            fromButton?.setTitle(item, for: .normal)
        }
    }
    
    @IBAction private func toButtonAction(_ sender: UIButton) {
        present(listViewController, animated: true)
        
        listViewController.didSelectItem = { [toButton] item in
            toButton?.setTitle(item, for: .normal)
        }
    }
    
    @IBAction private func swapButtonAction(_ sender: UIButton) {
        viewModel.swapTheConversion()
    }
}

// MARK: Helpers
extension CurrencyConverterViewController {
    private func setupBindings() {
        viewModel.isLoading
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: bag)
        
        viewModel.isLoading
            .map { $0 ? 1 : 0 }
            .drive(activityIndicator.rx.alpha)
            .disposed(by: bag)
        
        viewModel.isLoading
            .map { !$0 }
            .drive(
                fromButton.rx.isEnabled,
                toButton.rx.isEnabled,
                swapButton.rx.isEnabled
            )
            .disposed(by: bag)
        
        viewModel.currencySymbols
            .drive { [listViewController] list in
                listViewController.items = list
            }
            .disposed(by: bag)
        
        viewModel.errorMessage
            .emit { message in
                print(message)
            }
            .disposed(by: bag)
    }
}
