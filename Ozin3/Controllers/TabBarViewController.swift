//
//  TabBar.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import UIKit
import Localize_Swift

class TabBarViewController: UITabBarController {
    
    // let appearance = UITabBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateSelectedImagesForCurrentAppearance()
        }
    }
    func configure() {
        let home = HomeViewController()
        let search = SearchViewController()
        let favorites = FavoritesViewController()
        let profile = ProfileViewController()
        
        tabBar.backgroundColor = UIColor(named: "FFFFFF-1C2431")
        
        
        home.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "Home1"))
        search.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search"), selectedImage: UIImage(named: "Search1"))
        favorites.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favorite"), selectedImage: UIImage(named: "Favorite1"))
        profile.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "Profile1"))
        
        let nc1 = UINavigationController(rootViewController: home)
        let nc2 = UINavigationController(rootViewController: search)
        let nc3 = UINavigationController(rootViewController: favorites)
        let nc4 = UINavigationController(rootViewController: profile)
        
        setViewControllers([nc1, nc2, nc3, nc4], animated: true)
        
        home.navigationItem.title = ""
        search.navigationItem.title = "SEARCH".localized()
        favorites.navigationItem.title = "LIST".localized()
        profile.navigationItem.title = "PROFILE".localized()
    }
    
    func updateSelectedImagesForCurrentAppearance() {
        let homeSelectedImage = UIImage(named: "Home1")?.withRenderingMode(.alwaysOriginal)
        let searchSelectedImage = UIImage(named: "Search1")?.withRenderingMode(.alwaysOriginal)
        let favoritesSelectedImage = UIImage(named: "Favorite1")?.withRenderingMode(.alwaysOriginal)
        let profileSelectedImage = UIImage(named: "Profile1")?.withRenderingMode(.alwaysOriginal)
        
        if let items = tabBar.items {
            items[0].selectedImage = homeSelectedImage
            items[1].selectedImage = searchSelectedImage
            items[2].selectedImage = favoritesSelectedImage
            items[3].selectedImage = profileSelectedImage
        }
    }
}

