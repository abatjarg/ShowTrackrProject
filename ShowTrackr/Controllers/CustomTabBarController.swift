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
        
        let mainViewController = MainViewController()
        let mainNavController = UINavigationController(rootViewController: mainViewController)
        mainNavController.tabBarItem.title = "Home"
        
        let searchViewController = SearchViewController()
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        searchNavController.tabBarItem.title = "Search"
        
        let savedShowsViewController = SavedShowsViewController()
        let savedShowsNavController = UINavigationController(rootViewController: savedShowsViewController)
        savedShowsNavController.tabBarItem.title = "Saved Shows"
        
        viewControllers = [mainNavController, searchNavController, savedShowsNavController]
    }

}
