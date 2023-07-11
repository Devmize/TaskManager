//
//  TabBarCoordinator.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 12.05.2023.
//

import UIKit

final class TabBarCoordinator: TabBarCoordinatorProtocol {
    
    static let views: [CoordinatorProtocol] = [
        TodoCoordinator(),
        ChatCoordinator()
    ]
    
    static func configure() -> UITabBarController {
        var viewControllers: [UIViewController] = []
        
        for view in self.views {
            let viewController = view.configure()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.setNavigationBarHidden(false, animated: false)

            viewControllers.append(navigationController)
        }

        let tabBarController = TabBarController()
        tabBarController.viewControllers = viewControllers
        tabBarController.tabBar.tintColor = .black
        
        return tabBarController
    }
}
