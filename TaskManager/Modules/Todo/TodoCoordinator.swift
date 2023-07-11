//
//  TodoCoordinator.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 12.05.2023.
//

import UIKit

final class TodoCoordinator: TodoCoordinatorProtocol, CoordinatorProtocol {
     
    weak var view: TodoViewProtocol?
    
    func configure() -> UIViewController {
        let todoView = TodoViewController()
        todoView.tabBarItem = UITabBarItem(title: TabBarItem.todo.navTitle,
                                           image: TabBarItem.todo.image,
                                           tag: 0)
        let todoPresenter = TodoPresenter()
        let todoCoordinator = TodoCoordinator()
        
        todoView.presenter = todoPresenter
        todoPresenter.coordinator = todoCoordinator
        todoPresenter.view = todoView
        todoCoordinator.view = todoView

        return todoView
    }
    
    func openCreateTaskViewController(from view: TodoViewProtocol?) {
        let nextView = CreateTaskCoordinator().configure()
        
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.navigationBar.isHidden = false
        vc.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func openTaskViewController(from view: TodoViewProtocol?, task: Task) {
        let nextView = TaskCoordinator().configureWith(task: task)
        
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.navigationBar.isHidden = false
        vc.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func openSignInViewController(from view: TodoViewProtocol?) {
        let nextView = SignInCoordinator().configure()
        
        guard let vc = view as? UIViewController else { return }

        nextView.modalPresentationStyle = .fullScreen
        vc.present(nextView, animated: true)
    }
}
