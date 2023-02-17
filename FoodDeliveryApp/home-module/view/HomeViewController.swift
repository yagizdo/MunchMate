//
//  HomeViewController.swift
//  FoodDeliveryApp
//
//  Created by Yılmaz Yağız Dokumacı on 12.02.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var navbarProfileImage: UIImageView!
    
    @IBOutlet weak var homeSliderCollectionView: UICollectionView!
    
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
    }
}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeSliderCollectionView.dequeueReusableCell(withReuseIdentifier: "homeSliderCell", for: indexPath) as! HomeSliderCollectionViewCell
        
        cell.background.backgroundColor = UIColor(named: "containerBackgroundColor")
        cell.titleLabel.text = "The Fastest In Delivery Food"
        cell.titleLabel.spacing = 7
        cell.vectorImage.image = UIImage(named: "deliverVec")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
