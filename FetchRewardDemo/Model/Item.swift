//
//  Item.swift
//  FetchRewardDemo
//
//  Created by Aaron Cleveland on 9/10/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation

struct Item: Codable {
    let id: Int
    let listId: Int
    let name: String?
}

typealias Items = [Item]

