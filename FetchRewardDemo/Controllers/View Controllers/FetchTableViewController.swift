//
//  FetchTableViewController.swift
//  FetchRewardDemo
//
//  Created by Aaron Cleveland on 9/10/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class FetchTableViewController: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewDelegates()
        view.addSubview(tableView)
        tableView.addConstraintsToFillView(view)
    }
    
    private func tableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationItem.title = "Item List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension FetchTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
