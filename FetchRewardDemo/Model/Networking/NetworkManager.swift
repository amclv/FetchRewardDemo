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
    let baseURL = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json")

    var itemArray: [Item] = []

    func fetchItems(completion: @escaping () -> Void) {
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
                let item = try jsonDecoder.decode(Item.self, from: data)
                DispatchQueue.main.async {
                    self.itemArray.append(item)
                    completion()
                }
            } catch {
                print("Error decoding items: \(error)")
            }
        }.resume()
    }
}
