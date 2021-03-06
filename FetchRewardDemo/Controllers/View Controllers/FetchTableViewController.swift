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
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNavigationBar()
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return networkManager.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkManager.itemArray[section + 1]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = networkManager.itemArray[section + 1]?[0].listId else { return nil }
        let label = UILabel()
        label.text = "Section \(section)"
        label.textAlignment = .center
        label.backgroundColor = .systemRed
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        if let sectItems = networkManager.itemArray[indexPath.section + 1]?[indexPath.row] {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = sectItems.name
            cell.detailTextLabel?.text = "Id: \(sectItems.id)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        guard let selectedItems = networkManager.itemArray[indexPath.section + 1]?[indexPath.row],
            let name = selectedItems.name else { return }
        vc.id.text = "Id: \(selectedItems.id)"
        vc.listId.text = "Section: \(selectedItems.listId)"
        vc.name.text = "Name: \(name)"
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
