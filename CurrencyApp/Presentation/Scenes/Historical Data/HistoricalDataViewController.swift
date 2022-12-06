//  
//  HistoricalDataViewController.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 06/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HistoricalDataViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    private let viewModel: HistoricalDataViewModelType
    private let bag: DisposeBag = .init()
    
    // MARK: Init
    init(viewModel: HistoricalDataViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
}

// MARK: - Private Handlers
private extension HistoricalDataViewController {
    
    func setupBindings() {
        viewModel.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: bag)
        
        viewModel.errorMessage
            .subscribe { message in
                print(message)
            }
            .disposed(by: bag)
    }
}
