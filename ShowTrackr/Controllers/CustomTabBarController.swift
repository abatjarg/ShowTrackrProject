//
//  CustomTabBarController.swift
//  ShowTrackr
//
//  Created by abatjarg on 1/4/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tabBar.isTranslucent = false
        
        let mainViewController = MainViewController()
        let mainNavController = UINavigationController(rootViewController: mainViewController)
        mainNavController.tabBarItem.title = "Home"
        mainNavController.tabBarItem.image = UIImage(imageLiteralResourceName: "main")
        
        let searchViewController = SearchViewController()
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        searchNavController.tabBarItem.title = "Search"
        searchNavController.tabBarItem.image = UIImage(imageLiteralResourceName: "search")
        
        let savedShowsViewController = SavedShowsViewController()
        let savedShowsNavController = UINavigationController(rootViewController: savedShowsViewController)
        savedShowsNavController.tabBarItem.title = "Favorite"
        savedShowsNavController.tabBarItem.image = UIImage(imageLiteralResourceName: "favorite")
        
        let accountViewController = AccountViewController()
        let accountNavController = UINavigationController(rootViewController: accountViewController)
        accountNavController.tabBarItem.title = "Account"
        accountNavController.tabBarItem.image = UIImage(imageLiteralResourceName: "account")
        
        viewControllers = [mainNavController, searchNavController, savedShowsNavController, accountViewController]
    }

}
