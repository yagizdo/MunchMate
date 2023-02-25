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
    
    @IBOutlet weak var foodCollectionViewTopConstrait: NSLayoutConstraint!
    
    @IBOutlet weak var categoriesTitleLabel: UILabel!
    
    @IBOutlet weak var defaultNavbarView: UIView!
    
    @IBOutlet weak var searchNavbarView: UIView!
    
    @IBOutlet weak var foodSearchBar: UISearchBar!
    
    var selectedCategoryIndex = 0
    
    var categories = [Category(categoryName: "All", categoryIcon: "allIcon"),Category(categoryName: "Foods", categoryIcon: "foodsIcon"),Category(categoryName: "Drinks", categoryIcon: "drinksIcon"),Category(categoryName: "Desserts", categoryIcon: "dessertsIcon")]
    
    var foods = [Yemekler]()
    
    var homePresenterDelegate : ViewToPresenterHomeProtocol?
    
    var heightMap = [0:1840,1:1100,2:900,3:900] // 0-1-2-3 is categoryIndex number and 1840, 1100 etc is height values

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        // Tabbar settings
        tabbarSettings()
        
        // Create Module
        HomeRouter.createModule(ref: self)
        
        foodsLoadingIndicator.hidesWhenStopped = true
        foodsLoadingIndicator.startAnimating()
        
        // Get all foods
        homePresenterDelegate?.getAllFoods()
        
        // Set carts badge
        if let userEmail = AuthService.shared.currentUser?.email {
            NetworkService.shared.calculateCartItemsBadge(userMail: userEmail, vc: self)
        }
        
        // Searchbar
        foodSearchBar.searchTextField.backgroundColor = UIColor.white
        foodSearchBar.backgroundColor = UIColor(named: "backgroundColor")!
        foodSearchBar.delegate = self
        foodSearchBar.tintColor = UIColor(named: "activeOrangeColor")!
        foodSearchBar.barTintColor = UIColor(named: "backgroundColor")!
        foodSearchBar.clearsContextBeforeDrawing = true
    }
    
    func enableSearching() {
        hideViewWithAnimation(widget: homeSliderCollectionView, shouldHidden: true, alphaValue: 1)
        hideViewWithAnimation(widget: categoriesCollectionView, shouldHidden: true, alphaValue: 1)
        hideViewWithAnimation(widget: categoriesTitleLabel, shouldHidden: true, alphaValue: 1)
        hideViewWithAnimation(widget: defaultNavbarView, shouldHidden: true, alphaValue: 1)
        hideViewWithAnimation(widget: searchNavbarView, shouldHidden: false, alphaValue: 1)
        foodCollectionViewTopConstrait.constant = 8
        UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
        }
    }
    
    func hideViewWithAnimation(widget:UIView,shouldHidden:Bool,alphaValue:Int) {
        UIView.animate(withDuration: 0.5, animations: {
            widget.alpha = CGFloat(shouldHidden ?  0 : 1)
        }) { (finished) in
            if finished {
                //widget.isHidden = shouldHidden
                //widget.alpha = CGFloat(shouldHidden ?  0 : 1)
            }
        }
    }
    func disableSearching() {
        hideViewWithAnimation(widget: homeSliderCollectionView, shouldHidden: false, alphaValue: 1)
        hideViewWithAnimation(widget: categoriesCollectionView, shouldHidden: false, alphaValue: 1)
        hideViewWithAnimation(widget: categoriesTitleLabel, shouldHidden: false, alphaValue: 1)
        hideViewWithAnimation(widget: defaultNavbarView, shouldHidden: false, alphaValue: 1)
        hideViewWithAnimation(widget: searchNavbarView, shouldHidden: true, alphaValue: 1)
        UIView.animate(withDuration: 0.5) {
            self.foodCollectionViewTopConstrait.constant = 319
                self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillLayoutSubviews() {
       super.viewWillLayoutSubviews()
        self.tabBarController?.tabBar.layer.masksToBounds = true
        self.tabBarController?.tabBar.layer.cornerRadius = 30
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide Navigation Controller
        self.navigationController?.isNavigationBarHidden = true
        
        // disable pop gesture
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        // Set content size of homeScrollView
        homeScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(heightMap[selectedCategoryIndex]!))
       
        
//        // Set initial height of foodsCollectionView_constraint
//        self.foodsCollectionView_constraint.constant = self.view.bounds.height

        // Disable searching
        disableSearching()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Set final height of foodsCollectionView_constraint
        let newHeight = self.foodsCollectionView.contentSize.height
        if self.foodsCollectionView_constraint.constant != newHeight {
            self.foodsCollectionView_constraint.constant = newHeight
            self.view.layoutIfNeeded()
        }
    }
    
    func tabbarSettings() {
        if #available(iOS 13, *) {
                   // iOS 13:
                let appearance = self.tabBarController?.tabBar.standardAppearance
                    appearance?.configureWithOpaqueBackground()
                    appearance?.shadowImage = nil
                    appearance?.shadowColor = nil
                    appearance?.backgroundColor = UIColor.white
                    appearance?.stackedLayoutAppearance.normal.badgeBackgroundColor = UIColor(named: "activeOrangeColor")
                self.tabBarController?.tabBar.standardAppearance = appearance!
                self.tabBarController?.tabBar.scrollEdgeAppearance = appearance
               } else {
                   // iOS 12 and below:
                   self.tabBarController?.tabBar.shadowImage = UIImage()
                   self.tabBarController?.tabBar.backgroundImage = UIImage()
               }
    }
    
    @IBAction func searchButtonOnClick(_ sender: Any) {
        enableSearching()
    }
    
    @IBAction func searchNavbarBackButton(_ sender: Any) {
        DispatchQueue.main.async {
            self.homePresenterDelegate?.getAllFoods()
        }
        disableSearching()
    }
    // Segue prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodViewtoFoodDetail" {
            if let food = sender as? Yemekler {
                let vc = segue.destination as! FoodDetailViewController
                vc.incomingFood = food
            }
        }
    }
}


// EXTENSIONS


// Searchbar
extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            homePresenterDelegate?.getAllFoods()
        } else {
            homePresenterDelegate?.search(searchText: searchText)
        }
    }

    
}


// Food Detail
extension HomeViewController : FoodsViewtoFoodDetailProtocol {
    func goFoodDetail(indexPath: IndexPath) {
        let food = foods[indexPath.row]
        performSegue(withIdentifier: "foodViewtoFoodDetail", sender: food)
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
            
            // Delegate
            cell.foodsViewtoFoodDetailProtocolDelegate = self
            
            // Get food image
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    cell.foodImage.kf.setImage(with: url)
                }
                cell.foodImageLoadingIndicator.stopAnimating()
            }
            // Set food title and price
            cell.foodTitle.text = food.yemek_adi
            cell.foodPrice.text = "\(food.yemek_fiyat!) ₺"
            
            // Set index path
            cell.indexPath = indexPath
            return cell
        }
        
        return CategoryCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeSliderCollectionView {
            
        } else if collectionView == categoriesCollectionView {
            let selectedCategory = categories[indexPath.row]
            selectedCategoryIndex = indexPath.row
            homePresenterDelegate?.getFoodsByCategory(categoryName: selectedCategory.categoryName ?? "All")
            categoriesCollectionView.reloadData()
            homeScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(heightMap[selectedCategoryIndex]!))
        } else if collectionView == foodsCollectionView  {
            // Detail segue
            goFoodDetail(indexPath: indexPath)
        }
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
        homeScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(heightMap[selectedCategoryIndex]!))
        self.foodsCollectionView_constraint.constant = 1400
        foodsLoadingIndicator.stopAnimating()
        
    }
    
    func showError(error: Error) {
        AlertManager.showErrorSnackBar(vc: self, message: "Something went wrong!")
    }
}
