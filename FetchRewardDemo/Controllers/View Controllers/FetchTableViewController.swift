//
//  FetchTableViewController.swift
//  FetchRewardDemo
//
//  Created by Aaron Cleveland on 9/10/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class FetchTableViewController: UIViewController {
    
    // MARK: - Properties
    let networkManager = NetworkManager()
    
    // MARK: - Variables
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        fetchData()
    }
    
    private func configureTableView() {
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        tableViewDelegates()
        view.addSubview(tableView)
        tableView.addConstraintsToFillView(view)
    }
    
    private func fetchData() {
        networkManager.fetchItems {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func tableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Item List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension FetchTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkManager.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        let item = networkManager.itemArray[indexPath.row]
        cell.textLabel?.text = item[indexPath.row].name
        cell.detailTextLabel?.text = "\(item[indexPath.row].id)"
        return cell
    }
}
