//
//  ItemDetailViewController.swift
//  FetchRewardDemo
//
//  Created by Aaron Cleveland on 9/12/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var id = UILabel()
    var listId = UILabel()
    var name = UILabel()
    
    let itemVStack: UIStackView = {
        let itemVStack = UIStackView()
        itemVStack.translatesAutoresizingMaskIntoConstraints = false
        itemVStack.alignment = .fill
        itemVStack.distribution = .fill
        itemVStack.axis = .vertical
        return itemVStack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        configureLabels()
    }
    
    private func configureUI() {
        view.addSubview(itemVStack)
        itemVStack.center(inView: view)
    }
    
    private func configureLabels() {
        itemVStack.addArrangedSubview(name)
        name.textColor = .black
        itemVStack.addArrangedSubview(listId)
        listId.textColor = .black
        itemVStack.addArrangedSubview(id)
    }
}
