//
//  CartFoodTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 22.02.2023.
//

import UIKit

class CartFoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var foodTitleLabel: UILabel!
    
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    
    @IBOutlet weak var foodStepper: UIStepper!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
