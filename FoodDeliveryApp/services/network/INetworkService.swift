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
}
