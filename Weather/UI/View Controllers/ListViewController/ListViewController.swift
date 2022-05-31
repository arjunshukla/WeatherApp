//
//  ListViewController.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import UIKit

class ListViewController: UIViewController,
                          UITableViewDataSource,
                          UITableViewDelegate,
                          Storyboarded {

    @IBOutlet private weak var spinner: UIActivityIndicatorView!

    @IBOutlet private weak var listTableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                                        #selector(self.handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.red
            
            return refreshControl
        }()

    private var viewModel: ListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        self.setupTableView()
    }

    private func setupViewModel() {
        viewModel = ListViewModel(delegate: self)
    }

    private func setupTableView() {
        listTableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
        listTableView.addSubview(self.refreshControl)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        if let cellModel = viewModel.getCellModel(for: indexPath.row) {
            cell.configure(with: cellModel)
        }

        return cell
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.getForecasts()
    }
}

extension ListViewController: ListViewModelDelegate {
    func updateData() {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
            self.spinner.stopAnimating()
            self.listTableView.isHidden = self.spinner.isAnimating
            self.refreshControl.endRefreshing()
        }
    }
}
