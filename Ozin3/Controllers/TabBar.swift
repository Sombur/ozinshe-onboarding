//
//  TabBar.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import UIKit

class TabBar: UITabBarController {

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
    configure()
            
        }
        func configure() {
            let home = MainPageVC()
            let search = SearchVC()
            let favorites = FavoritesVC()
            let profile = ProfileVC()
            
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
            search.navigationItem.title = "Іздеу"
            favorites.navigationItem.title = "Тізім"
            profile.navigationItem.title = "Профиль"
            
            //UITabBar.appearance().tintColor = UIColor(named: "TabBar")
        }
    }



