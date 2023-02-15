//
//  INetworkService.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 15.02.2023.
//

import Foundation

protocol INetworkService {
    func getAllFoods()
    func searchFood(searchText:String)
    func getFoodsByCategory(categoryName:String)
    func addFoodToCart(userMail:String, food:Yemekler,piece:Int?)
    func getCartItems(userMail:String)
    func removeFoodFromCart(food_id:Int,userMail:String)
}
