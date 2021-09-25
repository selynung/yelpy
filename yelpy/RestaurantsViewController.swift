//
//  RestaurantsViewController.swift
//  yelpy
//
//  Created by Selyn Ung on 9/25/21.
//  Copyright © 2021 Selyn Ung. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    
    @IBOutlet weak var tableView: UITableView!
    
    // ––––– TODO: Next, place TableView outlet here
    
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [[String: Any]] = []
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAPIData()
        
        tableView.rowHeight = 150
    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    
    func getAPIData(){
        API.getRestaurants(){ (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
//            print(restaurants)
            self.restaurantsArray = restaurants
            self.tableView.reloadData()
        }
    }
    
    
    // ––––– TODO: Create tableView Extension and TableView Functionality
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Restaurant Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = restaurantsArray[indexPath.row]
        
        // Set Label to restaurant name for each cell
        cell.restaurantLabel.text = restaurant["name"] as? String ?? ""
        
        // Set Categories
        let categories = restaurant["categories"] as! [[String: Any]]
        cell.categoryLabel.text = categories[0]["title"] as? String
        
        // Set phone number
        cell.numberLabel.text = restaurant["display_phone"] as? String ?? ""
        
        // Set Ratings
        let rate = restaurant["rating"]
        let rating = "\(rate ?? "")"
        var ratingString = ""
        if rating.suffix(2) == ".5"{
            ratingString = "regular_" + rating.prefix(1) + "_half"
        }
        else {
            ratingString = "regular_" + rating
        }
        let image = UIImage(named:ratingString)
        cell.ratingImage.image = image
        
        // Set review count
        let review = restaurant["review_count"]
        let review_count = "\(review ?? "")"
        cell.reviewLabel.text = review_count
        
        // Set Image of restaurant
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restaurantImage.af.setImage(withURL: imageUrl!)
        }

        return cell
    }
    

}
