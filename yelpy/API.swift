//
//  API.swift
//  yelpy
//
//  Created by Selyn Ung on 9/25/21.
//  Copyright © 2021 Selyn Ung. All rights reserved.
//

import Foundation

struct API {



static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
    
    // ––––– TODO: Add your own API key!
    let apikey = "f55VtJR7XuZsYiqvKogB9JLUL--9tUYl9rcQowQQoT51vyLb3ZOh6abYe_AIU4kJs4cZAEC-JKPk-Z09FoAUgH1K5w0COkcqaRZMlVAk9mHTuVzboLQGEMntzGZPYXYx"
    
    // Coordinates for San Francisco
    let lat = 37.773972
    let long = -122.431297
    
    
    let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
    
    var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
    
    // Insert API Key to request
    request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
    
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: request) { (data, response, error) in
        // This will run when the network request returns
        if let error = error {
            print(error.localizedDescription)
        } else if let data = data {
            
    

            // ––––– TODO: Get data from API and return it using completion
            print(data)
            
            // 1. Convert json repspone to a dictionary
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            // 2. Grab the businesses data and convert it to an array of dictionaries for each restaurant
            let restaurants = dataDictionary["businesses"] as! [[String: Any]]
            
            // 3. completion is an escaping method which allows the data to be used outside of the closure
            return completion(restaurants)
            
//            return completion([[:]])
            
            }
        }
    
        task.resume()
    
    }
}
