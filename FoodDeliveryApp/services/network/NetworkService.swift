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
                print("Get all foods error : \(error.localizedDescription)")
            }
        }
    }
    
    // Search Food
    func searchFood(searchText: String, onSuccess: @escaping ([Yemekler]) -> Void, onFailure: @escaping (Error) -> Void) {
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
                        onSuccess(searchedList)
                    }
                   
                }
            } catch {
                onFailure(error)
                print("Search error : \(error.localizedDescription)")
            }
        }
    }
    
    
    // Foods by Category
    func getFoodsByCategory(categoryName: String, onSuccess: @escaping ([Yemekler]) -> Void) {
        if categoryName.lowercased() == "all" {
            getAllFoods { foods in
                onSuccess(foods)
            } onFailure: { error in
                print("Get foods by category error : \(error.localizedDescription)")
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
    func addFoodToCart(userMail: String, food: Yemekler, piece: Int?, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error) -> Void) {
        let params = ["yemek_adi":food.yemek_adi!,"yemek_resim_adi":food.yemek_resim_adi!,"yemek_fiyat":Int(food.yemek_fiyat!)!,"yemek_siparis_adet":piece!,"kullanici_adi":userMail] as [String : Any]
        
        AF.request("\(baseURL)/sepeteYemekEkle.php",method: .post,parameters: params).response {
            response in
            do {
                if let data = response.data {
                    let answer = try JSONDecoder().decode(CrudCevap.self, from: data)
                    onSuccess(true)
                }
            } catch {
                onFailure(error)
                print("Add error : \(error.localizedDescription)")
            }
        }
    }
    
    // Get Cart Items
    func getCartItems(userMail: String, onSuccess: @escaping ([CartFoodItem]) -> Void, onFailure: @escaping (Error) -> Void) {
        let params = ["kullanici_adi":userMail]
        
        AF.request("\(baseURL)/sepettekiYemekleriGetir.php",method: .post,parameters: params).response {
            response in
            do {
                if let data = response.data {
                    if data.count <= 5 {
                        onSuccess([])
                        return
                    }
                    let cartAnswer = try JSONDecoder().decode(SepetCevap.self, from: data)
                    if let incomingFoods = cartAnswer.sepet_yemekler {
                        self.cartFoods = incomingFoods
                        
                        onSuccess(self.groupCartItemsByFoods(items: incomingFoods))
                    }
                
                }
            } catch {
                onFailure(error)
                print("Get Cart Items error : \(error.localizedDescription)")
            }
        }
    }
    
    func groupCartItemsByFoods(items: [SepetYemekler]) -> [CartFoodItem] {
        var groupedItems = [String: (Int, Int, String?)]()
        for item in items {
            if let foodName = item.yemek_adi {
                if let existingItemCount = groupedItems[foodName] {
                    let updatedCount = existingItemCount.0 + (Int(item.yemek_siparis_adet ?? "0") ?? 0)
                    groupedItems[foodName] = (updatedCount, existingItemCount.1, item.yemek_resim_adi)
                } else {
                    if let price = Int(item.yemek_fiyat ?? "0") {
                        groupedItems[foodName] = (Int(item.yemek_siparis_adet ?? "0") ?? 0, price, item.yemek_resim_adi)
                    }
                }
            }
        }
        var foods = [CartFoodItem]()
        for (foodName, countAndPriceAndImageUrl) in groupedItems {
            let food = CartFoodItem(name: foodName, count: countAndPriceAndImageUrl.0, price: countAndPriceAndImageUrl.1, imageUrl: countAndPriceAndImageUrl.2)
            foods.append(food)
        }
        return foods
    }
    
    func calculateCartItemsBadge(userMail: String, vc: UIViewController) {
        getCartItems(userMail: userMail) { cartFoods in
            let cartTabbarItem = vc.tabBarController?.tabBar.items![1]
            cartTabbarItem?.badgeValue = "\(cartFoods.count)"
        } onFailure: { error in
            print("Calculate cart badge error : \(error.localizedDescription)")
        }
    }
    
    // Delete food in cart
    func removeFoodWithNameFromCart(foodName: String, userMail: String, onSuccess: @escaping ([CartFoodItem]) -> Void, onFailure: @escaping (Error) -> Void) {
        // find all cart items with matching foodName
        let cartItems = cartFoods.filter { $0.yemek_adi == foodName }
        if cartItems.isEmpty {
            let error = NSError(domain: "Cart Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not find any items in cart"])
            onFailure(error)
            return
        }
        
        // delete each cart item with matching foodName
        var deletedCount = 0
        for cartItem in cartItems {
            let params = ["sepet_yemek_id": cartItem.sepet_yemek_id, "kullanici_adi": userMail]
            
            AF.request("\(baseURL)/sepettenYemekSil.php", method: .post, parameters: params).response { response in
                do {
                    if let data = response.data {
                        let answer = try JSONDecoder().decode(CrudCevap.self, from: data)
                        if answer.success == 1 {
                            deletedCount += 1
                            if deletedCount == cartItems.count {
                                // get updated cart items and return them
                                self.getCartItems(userMail: userMail) { cartFoods in
                                    onSuccess(cartFoods)
                                } onFailure: { error in
                                    onFailure(error)
                                    print("Remove error : \(error.localizedDescription)")
                                }
                            }
                        } else {
                            print("Success : \(answer.success!)")
                            print("Message : \(answer.message!)")
                        }
                    }
                } catch {
                    onFailure(error)
                    print(error.localizedDescription)
                }
            }
        }
    }
}
