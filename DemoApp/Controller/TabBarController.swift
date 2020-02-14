//
//  TabBarController.swift
//  DemoApp
//
//  Created by WESLEY on 2020/2/14.
//  Copyright © 2020 Wesley. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController , UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabBar()
        // Do any additional setup after loading the view.
    }

    func initTabBar() {
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        
        let resultVC = ResultVC()
        resultVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let favoriteVC = FavoriteVC()
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        viewControllers = [resultVC,favoriteVC]
    }
    
}
