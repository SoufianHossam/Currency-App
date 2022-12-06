//  
//  HistoricalDataViewController.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 06/12/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBindings()
        
        viewModel.fetchHistoricalData()
    }
}

// MARK: - Private Handlers
private extension HistoricalDataViewController {
    func setupTableView() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionData>(
          configureCell: { _, _, _, item in
              let cell = UITableViewCell()
              var configuration = UIListContentConfiguration.cell()
              configuration.text = item
              cell.contentConfiguration = configuration
            return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
          dataSource.sectionModels[index].header
        }
        
        viewModel.sectionData
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
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
