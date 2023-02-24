//
//  category.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 18.02.2023.
//

import Foundation

class Category {
    var categoryName:String?
    var categoryIcon:String?
    
    init(categoryName: String?, categoryIcon: String?) {
        self.categoryName = categoryName
        self.categoryIcon = categoryIcon
    }
}
