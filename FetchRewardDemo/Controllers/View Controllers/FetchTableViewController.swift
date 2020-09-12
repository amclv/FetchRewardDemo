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
    var items: Items!

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
                self.filteringData()
                self.tableView.reloadData()
            }
        }
    }
    
    private func filteringData() {
        self.networkManager.itemArray.sort() {
            $0.listId < $1.listId
        }
        self.networkManager.itemArray = self.networkManager.itemArray.filter { ($0.name?.contains(" ") ?? false) }
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
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return items.count
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = items.listId
        label.backgroundColor = .lightGray
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        let item = self.items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "\(item.id)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
