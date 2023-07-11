//
//  TaskCoordinator.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 25.05.2023.
//

import UIKit

final class TaskCoordinator: TaskCoordinatorProtocol, CoordinatorProtocol {
 
    weak var view: TaskViewProtocol?
    
    func configure() -> UIViewController {
        let taskView = TaskViewController()
        let taskPresenter = TaskPresenter()
        let taskCoordinator = TaskCoordinator()
        
        taskView.presenter = taskPresenter
        taskPresenter.coordinator = taskCoordinator
        taskPresenter.view = taskView
        taskCoordinator.view = taskView

        return taskView
    }
    
    func configureWith(task: Task) -> UIViewController {
        let taskView = TaskViewController()
        let taskPresenter = TaskPresenter()
        let taskCoordinator = TaskCoordinator()
        
        taskView.presenter = taskPresenter
        taskPresenter.coordinator = taskCoordinator
        taskPresenter.view = taskView
        taskPresenter.task = task
        taskCoordinator.view = taskView

        return taskView
    }
    
    func dismissTaskController() {
        guard let vc = self.view as? UIViewController else { return }
        vc.navigationController?.popViewController(animated: true)
    }
    
}
