//
//  TabBar.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 27.03.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    var firstTabNavigationController: UINavigationController!
    var secondTabNavigationController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        firstTabNavigationController = UINavigationController.init(rootViewController: LogInViewController())
        secondTabNavigationController = UINavigationController.init(rootViewController: SettingsViewController())
        
        self.viewControllers = [firstTabNavigationController, secondTabNavigationController]
        
        let item1 = UITabBarItem(title: "Файлы",
                                 image: UIImage(systemName: "list.bullet"), tag: 0)
        let item2 = UITabBarItem(title: "Настройки",
                                 image: UIImage(systemName: "pencil"), tag: 1)
        
        firstTabNavigationController.tabBarItem = item1
        secondTabNavigationController.tabBarItem = item2
        
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().backgroundColor = .systemGray6
    }
}
