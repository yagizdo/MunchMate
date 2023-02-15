//
//  NetworkService.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 15.02.2023.
//

import Foundation
import Alamofire

class NetworkService : INetworkService {
    static let shared = NetworkService()

    var baseURL = "http://kasimadalan.pe.hu/yemekler"
    var foodsConstants = ["Izgara Somon","Izgara Tavuk","Köfte","Lazanya","Makarna","Pizza"]
    var drinksConstants = ["Ayran","Fanta","Kahve","Su"]
    var desertsConstants = ["Baklava","Kadayıf","Sütlaç","Tiramisu"]
    
    var allFoods = [Yemekler]()
    

    
    private init() {}
    
    // All Foods
    func getAllFoods() {
        AF.request("\(baseURL)/tumYemekleriGetir.php",method: .get).response {
            response in
            do {
                if let data = response.data {
                    let foodsAnswer = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let incomingFoods = foodsAnswer.yemekler {
                        for food in incomingFoods {
                            if self.foodsConstants.contains(food.yemek_adi!) {
                                food.yemek_kategori = "Food"
                            } else if self.drinksConstants.contains(food.yemek_adi!) {
                                food.yemek_kategori = "Drink"
                            } else if self.desertsConstants.contains(food.yemek_adi!) {
                                food.yemek_kategori = "Desert"
                            } else {
                                food.yemek_kategori = "Others"
                            }
                            print("Food : \(food.yemek_adi!) - \(food.yemek_kategori!)")
                            
                        }
                        self.allFoods = incomingFoods
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // Search Food
    func searchFood(searchText: String) {
        var searchedList = [Yemekler]()
        
        AF.request("\(baseURL)/tumYemekleriGetir.php",method: .get).response {
            response in
            do {
                if let data = response.data {
                    let foodsAnswer = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let incomingFoods = foodsAnswer.yemekler {
                        for food in incomingFoods {
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
    
    
    // Foods by Category
    func getFoodsByCategory(categoryName: String) {
        var Categorizedfoods = [Yemekler]()
        
        for food in self.allFoods {
            if  food.yemek_kategori!.lowercased().contains(categoryName.lowercased()) {
                Categorizedfoods.append(food)
            }
        }
        
        for categorizedFood in Categorizedfoods {
            print("categorizedFood : \(categorizedFood.yemek_adi!) - \(categorizedFood.yemek_kategori!)")
        }
    }
    
  // Add to Cart
    func addFoodToCart(userMail: String, food: Yemekler, piece: Int?) {
        
        let params = ["yemek_adi":food.yemek_adi!,"yemek_resim_adi":food.yemek_resim_adi!,"yemek_fiyat":Int(food.yemek_fiyat!)!,"yemek_siparis_adet":piece!,"kullanici_adi":userMail] as [String : Any]
        
        AF.request("\(baseURL)/sepeteYemekEkle.php",method: .post,parameters: params).response {
            response in
            
            do {
                if let data = response.data {
                    let answer = try JSONDecoder().decode(CrudCevap.self, from: data)
                    print("------Insert------")
                    print("Success : \(answer.success!)")
                    print("Message : \(answer.message!)")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

