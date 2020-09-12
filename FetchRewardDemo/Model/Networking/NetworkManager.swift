//
//  NetworkManager.swift
//  FetchRewardDemo
//
//  Created by Aaron Cleveland on 9/10/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation

/// HTTP request methods.
enum RequestMethod: String {
    /// HTTP GET
    case get = "GET"
    /// HTTP POST
    case post = "POST"
    /// HTTP PUT
    case put = "PUT"
    /// HTTP PATCH
    case patch = "PATCH"
    /// HTTP DELETE
    case delete = "DELETE"
}

class NetworkManager {

    var itemArray: [Int: [Item]] = [:]

    func fetchItems(completion: @escaping () -> Void) {
        let baseURL = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json")
        var request = URLRequest(url: baseURL!)
        request.httpMethod = RequestMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data return from data task")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                var items = try jsonDecoder.decode([Item].self, from: data)
                items = items.filter { $0.name != nil && $0.name != "" }
                items = items.sorted(by: {
                    // guaranteed != nil in filter operation
                    let name1 = $0.name!
                    let name2 = $1.name!
                    
                    var number1 = ""
                    var number2 = ""
                    
                    for char in name1 {
                        if char.isNumber {
                            number1.append(char)
                        }
                    }
                    
                    for char in name2 {
                        if char.isNumber {
                            number2.append(char)
                        }
                    }
                    return Int(number1) ?? 0 < Int(number2) ?? 0
                })
                
                for item in items {
                    if self.itemArray[item.listId] != nil {
                        self.itemArray[item.listId]?.append(item)
                    } else {
                        self.itemArray[item.listId] = [item]
                    }
                }
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("Error decoding items: \(error)")
            }
        }.resume()
    }
}
