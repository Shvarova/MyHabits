//
//  TabBarController.swift
//  MyHabits
//
//  Created by Дина Шварова on 09.01.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    func setupControllers() {
        let habits = createController(viewController: HabitsViewController(), itemName: "Привычки", ItemImage: "habits_icon")
        let info = createController(viewController: InfoViewController(), itemName: "Информация", ItemImage: "info_icon")
        viewControllers = [habits, info]
    }
        
    func createController(viewController: UIViewController, itemName: String, ItemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(named: ItemImage)?.withAlignmentRectInsets(.init(top: 7, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item
        
        UITabBar.appearance().tintColor = .Global.purple
        UITabBar.appearance().backgroundColor = .systemGray5
        return navigationController
    }
}

