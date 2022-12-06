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
    @IBOutlet private weak var detailsButton: UIButton!
    
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

        setupTextFields()
        setupBindings()
        
        viewModel.fetchCurrencySymbols()
    }
    
    // MARK: Actions
    @IBAction private func fromButtonAction(_ sender: UIButton) {
        present(listViewController, animated: true)
        
        listViewController.didSelectItem = { [weak self] item in
            self?.fromButton?.setTitle(item, for: .normal)
            self?.viewModel.fromCurrencyRelay.accept(item)
        }
    }
    
    @IBAction private func toButtonAction(_ sender: UIButton) {
        present(listViewController, animated: true)
        
        listViewController.didSelectItem = { [weak self] item in
            self?.toButton?.setTitle(item, for: .normal)
            self?.viewModel.toCurrencyRelay.accept(item)
        }
    }
    
    @IBAction private func swapButtonAction(_ sender: UIButton) {
        viewModel.swapTheConversion()
    }
}

// MARK: Helpers
extension CurrencyConverterViewController {
    private func setupTextFields() {
        fromTextField.text = "\(viewModel.amountRelay.value.value)"
        
        fromTextField.keyboardType = .decimalPad
        toTextField.keyboardType = .decimalPad
    }
    
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
        
        fromTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .map { .from(Double($0) ?? 0) }
            .bind(to: viewModel.amountRelay)
            .disposed(by: bag)
        
        toTextField.rx.text
            .orEmpty
            .skip(1)
            .distinctUntilChanged()
            .map { .to(Double($0) ?? 0) }
            .bind(to: viewModel.amountRelay)
            .disposed(by: bag)
        
        viewModel.convertedCurrency
            .drive { [weak self] in
                switch $0 {
                case .to:
                    self?.fromTextField.text = "\($0.value)"
                    
                case .from:
                    self?.toTextField.text = "\($0.value)"
                }
            }
            .disposed(by: bag)
        
        viewModel.fromCurrencyRelay
            .skip(1)
            .bind(to: fromButton.rx.title(for: .normal))
            .disposed(by: bag)
        
        viewModel.toCurrencyRelay
            .skip(1)
            .bind(to: toButton.rx.title(for: .normal))
            .disposed(by: bag)
        
        viewModel.isCurrenciesSelected
            .bind(to: detailsButton.rx.isEnabled)
            .disposed(by: bag)
        
        detailsButton.rx.tap
            .bind(to: viewModel.detailsRelay)
            .disposed(by: bag)
    }
}
