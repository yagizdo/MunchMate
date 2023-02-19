//
//  HomeViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 12.02.2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeScrollView: UIScrollView!
    
    @IBOutlet weak var navbarProfileImage: UIImageView!
    
    @IBOutlet weak var homeSliderCollectionView: UICollectionView!
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var foodsCollectionView: UICollectionView!
    
    //@IBOutlet weak var categoriesTitleLabel: UILabel!
    
    @IBOutlet weak var foodsCollectionView_constraint: NSLayoutConstraint!
    
    //@IBOutlet weak var navbarUsernameLbl: UILabel!
    
    @IBOutlet weak var foodsLoadingIndicator: UIActivityIndicatorView!
    
    var selectedCategoryIndex = 0
    
    var categories = [Category(categoryName: "All", categoryIcon: "allIcon"),Category(categoryName: "Foods", categoryIcon: "foodsIcon"),Category(categoryName: "Drinks", categoryIcon: "drinksIcon"),Category(categoryName: "Deserts", categoryIcon: "dessertsIcon"),Category(categoryName: "Others", categoryIcon: "othersIcon"),]
    
    var foods = [Yemekler]()
    
    var homePresenterDelegate : ViewToPresenterHomeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Hide Navigation Controller
        self.navigationController?.isNavigationBarHidden = true
        // disable pop gesture
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // We turn the profile picture into a circle.
        navbarProfileImage.layer.borderWidth = 1
        navbarProfileImage.layer.masksToBounds = false
        navbarProfileImage.layer.borderColor = UIColor.black.cgColor
        navbarProfileImage.layer.cornerRadius = navbarProfileImage.frame.height/2
        navbarProfileImage.clipsToBounds = true
        
        // Set homeSlider Collection View
        homeSliderCollectionView.delegate = self
        homeSliderCollectionView.dataSource = self
        
        // Set Categories Collection View
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        // Set Food Collection View
        foodsCollectionView.delegate = self
        foodsCollectionView.dataSource = self
        
        // Create Module
        HomeRouter.createModule(ref: self)
        
        foodsLoadingIndicator.hidesWhenStopped = true
        foodsLoadingIndicator.startAnimating()
        
        // Get all foods
        homePresenterDelegate?.getAllFoods()
    }
    
    override func viewDidLayoutSubviews() {
        self.foodsCollectionView_constraint.constant = self.foodsCollectionView.contentSize.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        homeScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+128)
    }
    
}


extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeSliderCollectionView {
            return 2
        } else if collectionView == categoriesCollectionView {
            return categories.count
        } else if collectionView == foodsCollectionView  {
            return foods.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Home Slider
        if collectionView == homeSliderCollectionView {
            let cell = homeSliderCollectionView.dequeueReusableCell(withReuseIdentifier: "homeSliderCell", for: indexPath) as! HomeSliderCollectionViewCell
            
            cell.background.backgroundColor = UIColor(named: "containerBackgroundColor")
            cell.titleLabel.text = "The Fastest In Delivery Food"
            cell.titleLabel.spacing = 7
            cell.vectorImage.image = UIImage(named: "deliverVec")
            // Set Cell shadow
            cell.layer.cornerRadius = 15.0
            cell.layer.borderWidth = 0.0
            cell.layer.shadowColor = UIColor(named: "blackColor")!.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 0.1
            cell.layer.masksToBounds = false
            return cell
        }
        
        // Categories
        else if collectionView == categoriesCollectionView {
            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            let category = categories[indexPath.row]
            
            if indexPath.row == selectedCategoryIndex
            {
                cell.contentView.backgroundColor = UIColor(named: "containerBackgroundColor")!
                
                
            } else {
                cell.contentView.backgroundColor = UIColor.white
                
            }
            cell.categoryTitle.textColor = UIColor(named: "blackColor")
            cell.contentView.layer.borderColor = UIColor(named: "containerBackgroundColor")!.cgColor
            cell.contentView.layer.borderWidth = 2
            // Set Cell shadow
            cell.layer.cornerRadius = 15.0
            cell.layer.borderWidth = 0.0
            cell.layer.shadowColor = UIColor(named: "blackColor")!.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 0.1
            cell.layer.masksToBounds = false
            
            // Set category icon and title
            cell.categoryTitle.text = category.categoryName
            cell.categoryIcon.image = UIImage(named: category.categoryIcon ?? "xmark.circle")
            return cell
            
        }
        
        // Food Collection View
        else if collectionView == foodsCollectionView {
            let cell = foodsCollectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell
            let food = foods[indexPath.row]
           
            cell.contentView.backgroundColor = UIColor.white
            cell.foodTitle.textColor = UIColor(named: "blackColor")
            cell.contentView.layer.borderColor = UIColor(named: "containerBackgroundColor")!.cgColor
            cell.contentView.layer.borderWidth = 2
            cell.foodImageLoadingIndicator.hidesWhenStopped = true
            cell.foodImageLoadingIndicator.startAnimating()
            
            // Get food image
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    cell.foodImage.kf.setImage(with: url)
                }
                cell.foodImageLoadingIndicator.stopAnimating()
            }
            // Set food title
            cell.foodTitle.text = food.yemek_adi
            return cell
        }
        
        return CategoryCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath.row
        categoriesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == homeSliderCollectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else if collectionView == categoriesCollectionView {
            
            return CGSize(width: 90, height: 90)
        } else if collectionView == foodsCollectionView  {
            
            let screenwidth = UIScreen.main.bounds.width
            let itemWidth = (screenwidth - 70)/2

            return CGSize(width: itemWidth, height: itemWidth * 1.05)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == homeSliderCollectionView {
            return 0
        } else if collectionView == categoriesCollectionView {
            return 15
        } else if collectionView == foodsCollectionView  {
            return 16
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == homeSliderCollectionView {
            return 0
        } else if collectionView == categoriesCollectionView {
            return 15
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoriesCollectionView {
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        } else if collectionView == foodsCollectionView  {
            return UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        }
        return UIEdgeInsets.zero
    }
    
    
}

extension HomeViewController : PresenterToViewHomeProtocol {
    func sendDataToView(foods: [Yemekler]) {
        self.foods = foods
        foodsCollectionView.reloadData()
        foodsLoadingIndicator.stopAnimating()
        
    }
    
    func showError(error: Error) {
        AlertManager.showErrorSnackBar(vc: self, message: "Something went wrong!")
    }
}
