//
//  CreateTaskPresenter.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import UIKit

final class CreateTaskPresenter: CreateTaskPresenterProtocol {
    
    weak var view: CreateTaskViewProtocol?
    var coordinator: CreateTaskCoordinatorProtocol?
    
    func createTask(title: String, content: String) {
        let task = Task(title: title, content: content)
        FirestoreService.shared.saveTaskWith(task: task) { [weak self] result in
            switch result {
            case .success(let task):
                print(task)
                self?.coordinator?.dismissCreateTaskController()
            case .failure(let error):
                print(error)
            }
        }
    }
}
