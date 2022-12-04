//  
//  CurrencyConverterViewController.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import UIKit
import RxSwift

class CurrencyConverterViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var fromButton: UIButton!

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
        
        viewModel.fetchCurrencySymbols()
        
        setupListViewController()
        setupBindings()
        
    }

    @IBAction func fromButtonAction(_ sender: UIButton) {
        present(listViewController, animated: true)
    }
}

extension CurrencyConverterViewController {
    func setupBindings() {
        viewModel.currencySymbols
            .drive { [listViewController] list in
                listViewController.items = list
            }
            .disposed(by: bag)
    }
    
    func setupListViewController() {
        listViewController.didSelectItem = { item in
            print(item)
        }
    }
}
