//  
//  CurrencyConverterViewController.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 04/12/2022.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var fromButton: UIButton!

    // MARK: Properties
    private let viewModel: CurrencyConverterViewModelType
    private let listViewController = ListViewController()
    
    // MARK: Init
    init(viewModel: CurrencyConverterViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    var list: [String] = [] {
        didSet {
            listViewController.items = list.sorted()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListCurrencySymbolsUseCase().fetchCurrencySymbols { [weak self] result in
            switch result {
            case .success(let value):
                self?.list = value.symbols
                print(value.symbols)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        listViewController.didSelectItem = { item in
            print(item)
        }
    }

    @IBAction func fromButtonAction(_ sender: UIButton) {
        present(listViewController, animated: true)
    }
}
