//
//  MainTabBarController.swift
//  Weather
//
//  Created by Sergey Savinkov on 25.03.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupViews()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .black
        tabBar.alpha = 1
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.layer.borderColor = UIColor.gray.cgColor
        tabBar.layer.borderWidth = 0.2
    }
    
    private func setupViews() {
        
        let mainVC = WeatherViewController()
        let searchVC = SearchWeatherViewController()
        
        setViewControllers([mainVC, searchVC], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(systemName: "location.circle")
        items[1].image = UIImage(systemName: "magnifyingglass")
    }
}
