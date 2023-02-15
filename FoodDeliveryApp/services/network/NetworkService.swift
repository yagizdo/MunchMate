//
//  NetworkService.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 15.02.2023.
//

import Foundation
import Alamofire

class NetworkService : INetworkService {
    var baseURL = "http://kasimadalan.pe.hu/yemekler"
    
    func getAllFoods() {
        AF.request("\(baseURL)/tumYemekleriGetir.php",method: .get).response {
            response in
            do {
                if let data = response.data {
                    let foodsAnswer = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let foods = foodsAnswer.yemekler {
                        for food in foods {
                            print("Food : \(food.yemek_adi!)")
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func searchFood(searchText: String) {
        var searchedList = [Yemekler]()
        
        AF.request("\(baseURL)/tumYemekleriGetir.php",method: .get).response {
            response in
            do {
                if let data = response.data {
                    let foodsAnswer = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let foods = foodsAnswer.yemekler {
                        for food in foods {
                            if food.yemek_adi!.lowercased().contains(searchText.lowercased()) {
                                searchedList.append(food)
                            }
                        }
                    }
                }
                for searchedFood in searchedList {
                    print("Searched Foods : \(searchedFood.yemek_adi!)")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

