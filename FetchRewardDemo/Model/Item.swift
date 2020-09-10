//
//  Item.swift
//  FetchRewardDemo
//
//  Created by Aaron Cleveland on 9/10/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation

struct ItemElement: Codable {
    let id: Int
    let listID: Int
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case listID = "listId"
        case name = "name"
    }
}

typealias Item = [ItemElement]