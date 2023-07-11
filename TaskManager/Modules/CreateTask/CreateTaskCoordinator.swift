//
//  CreateTaskCoordinator.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import UIKit

final class CreateTaskCoordinator: CreateTaskCoordinatorProtocol, CoordinatorProtocol {
    
    weak var view: CreateTaskViewProtocol?
    
    func configure() -> UIViewController {
        let createTaskView = CreateTaskViewController()
        let createTaskPresenter = CreateTaskPresenter()
        let createTaskCoordinator = CreateTaskCoordinator()
        
        createTaskView.presenter = createTaskPresenter
        createTaskPresenter.coordinator = createTaskCoordinator
        createTaskPresenter.view = createTaskView
        createTaskCoordinator.view = createTaskView

        return createTaskView
    }
    
    func dismissCreateTaskController() {
        guard let vc = self.view as? UIViewController else { return }
        vc.navigationController?.popViewController(animated: true)
    }
    
}
