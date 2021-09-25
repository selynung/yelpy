//
//  RestaurantCell.swift
//  yelpy
//
//  Created by Selyn Ung on 9/25/21.
//  Copyright © 2021 Selyn Ung. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    // Add Movie Variable + didset
    var r: Restaurant! {
        didSet {
            restaurantLabel.text = r.name
            categoryLabel.text = r.mainCategory
            numberLabel.text = r.phone
            reviewLabel.text = String(r.reviews) + " reviews"
            
            // set images
            ratingImage.image = Stars.dict[r.rating]!
            restaurantImage.af.setImage(withURL: r.imageURL!)
            restaurantImage.layer.cornerRadius = 10
            restaurantImage.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
