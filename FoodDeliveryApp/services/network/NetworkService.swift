//
//  NetworkService.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 15.02.2023.
//

import Foundation
import Alamofire
import UIKit

class NetworkService : INetworkService {
    static let shared = NetworkService()

    var baseURL = "http://kasimadalan.pe.hu/yemekler"
    var foodsConstants = ["Izgara Somon","Izgara Tavuk","Köfte","Lazanya","Makarna","Pizza"]
    var drinksConstants = ["Ayran","Fanta","Kahve","Su"]
    var desertsConstants = ["Baklava","Kadayıf","Sütlaç","Tiramisu"]
    
    var allFoods = [Yemekler]()
    var cartFoods = [SepetYemekler]()

    
    private init() {}
    
    // All Foods
    func getAllFoods(onSuccess: @escaping ([Yemekler]) -> Void, onFailure: @escaping (Error) -> Void) {
        AF.request("\(baseURL)/tumYemekleriGetir.php",method: .get).response {
            response in
            do {
                if let data = response.data {
                    let foodsAnswer = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let incomingFoods = foodsAnswer.yemekler {
                        for food in incomingFoods {
                            if self.foodsConstants.contains(food.yemek_adi!) {
                                food.yemek_kategori = "Foods"
                            } else if self.drinksConstants.contains(food.yemek_adi!) {
                                food.yemek_kategori = "Drinks"
                            } else if self.desertsConstants.contains(food.yemek_adi!) {
                                food.yemek_kategori = "Desserts"
                            } else {
                                food.yemek_kategori = "Others"
                            }
                        }
                        onSuccess(incomingFoods)
                        self.allFoods = incomingFoods
                    }
                }
            } catch {
                onFailure(error)
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
    func getFoodsByCategory(categoryName: String, onSuccess: @escaping ([Yemekler]) -> Void) {
        if categoryName.lowercased() == "all" {
            getAllFoods { foods in
                onSuccess(foods)
            } onFailure: { error in
                print(error.localizedDescription)
            }
        } else {
            var categorizedfoods = [Yemekler]()
            
            for food in self.allFoods {
                if  food.yemek_kategori!.lowercased().contains(categoryName.lowercased()) {
                    categorizedfoods.append(food)
                }
            }
            onSuccess(categorizedfoods)
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
    
    // Get Cart Items
    func getCartItems(userMail: String, onSuccess: @escaping ([SepetYemekler]) -> Void, onFailure: @escaping (Error) -> Void) {
        let params = ["kullanici_adi":userMail]
        
        AF.request("\(baseURL)/sepettekiYemekleriGetir.php",method: .post,parameters: params).response {
            response in
            do {
                if let data = response.data {
                    let cartAnswer = try JSONDecoder().decode(SepetCevap.self, from: data)
                    if let incomingFoods = cartAnswer.sepet_yemekler {
                        self.cartFoods = incomingFoods
                        onSuccess(incomingFoods)
                    }
                    for food in self.cartFoods {
                        print("D : \(food.yemek_adi!) - \(food.sepet_yemek_id!)")
                    }
                }
            } catch {
                onFailure(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func calculateCartItemsBadge(userMail: String, vc: UIViewController) {
        getCartItems(userMail: userMail) { cartFoods in
            let cartTabbarItem = vc.tabBarController?.tabBar.items![1]
            cartTabbarItem?.badgeValue = "\(cartFoods.count)"
        } onFailure: { error in
            print("error: \(error.localizedDescription)")
        }
    }
    
    // Delete food in cart
    func removeFoodFromCart(food_id: Int, userMail: String) {
        let params = ["sepet_yemek_id":food_id,"kullanici_adi":userMail] as [String : Any]
        
        AF.request("\(baseURL)/sepettenYemekSil.php",method: .post,parameters: params).response {
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
