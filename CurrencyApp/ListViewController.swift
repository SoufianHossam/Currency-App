//
//  ListViewController.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 03/12/2022.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var didSelectItem: ((String) -> Void)?
    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        configuration.text = items[indexPath.row]
        cell.contentConfiguration = configuration
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem?(items[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: false)
        dismiss(animated: true)
    }
}
