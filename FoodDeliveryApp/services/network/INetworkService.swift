//
//  INetworkService.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 15.02.2023.
//

import Foundation
import UIKit

protocol INetworkService {
    func getAllFoods(onSuccess: @escaping ([Yemekler]) -> Void, onFailure: @escaping (Error) -> Void)
    func searchFood(searchText:String)
    func getFoodsByCategory(categoryName:String,onSuccess: @escaping ([Yemekler]) -> Void)
    func addFoodToCart(userMail:String, food:Yemekler,piece:Int?,onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error) -> Void)
    func getCartItems(userMail:String,onSuccess: @escaping ([SepetYemekler]) -> Void, onFailure: @escaping (Error) -> Void)
    func calculateCartItemsBadge(userMail:String,vc:UIViewController)
    func removeFoodFromCart(food_id:Int,userMail:String,onSuccess: @escaping ([SepetYemekler]) -> Void, onFailure: @escaping (Error) -> Void)
}
