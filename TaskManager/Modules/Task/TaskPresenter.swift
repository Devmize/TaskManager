//
//  TaskPresenter.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 25.05.2023.
//

import UIKit

final class TaskPresenter: TaskPresenterProtocol {
    
    weak var view: TaskViewProtocol?
    var coordinator: TaskCoordinatorProtocol?
    
    var task: Task?
    
    func updateTask(title: String, content: String, status: String) {
        let task = Task(id: self.task!.id, title: title, content: content, status: TaskStatus(rawValue: status)!)
        FirestoreService.shared.saveTaskWith(task: task) { [weak self] result in
            switch result {
            case .success(let task):
                print(task)
                self?.coordinator?.dismissTaskController()
            case .failure(let error):
                print(error)
            }
        }
    }
}
