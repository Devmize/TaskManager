//
//  AppCoordinator.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 12.05.2023.
//

import UIKit

final class AppCoordinator {
    
    func authViewController() -> UIViewController {
        return SignInCoordinator().configure()
    }
    
    func mainViewController() -> UIViewController {
        return TabBarCoordinator.configure()
    }
}
