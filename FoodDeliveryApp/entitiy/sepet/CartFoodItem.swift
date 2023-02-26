//
//  CartFoodItem.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 26.02.2023.
//

import Foundation

class CartFoodItem {
    let name: String
    let count: Int
    let price: Int
    let imageUrl: String?
    
    init(name: String, count: Int, price: Int, imageUrl: String?) {
        self.name = name
        self.count = count
        self.price = price
        self.imageUrl = imageUrl
    }
}
