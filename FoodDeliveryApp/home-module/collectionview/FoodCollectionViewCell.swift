//
//  FoodCollectionViewCell.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 19.02.2023.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodTitle: UILabel!
    
    @IBOutlet weak var foodPrice: UILabel!
    
    @IBAction func addToCartButton(_ sender: Any) {
    }
}
