//
//  TodoPresenter.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 12.05.2023.
//

import Foundation
import FirebaseAuth

final class TodoPresenter: TodoPresenterProtocol {
    
    weak var view: TodoViewProtocol?
    var coordinator: TodoCoordinatorProtocol?
    var todoTasks: [Task] = []
    var inProgressTasks: [Task] = []
    var completedTasks: [Task] = []
    var filteredTasks: [Task] = []
    
    func updateTasks(tasks: [Task]) {
        self.todoTasks = []
        self.inProgressTasks = []
        self.completedTasks = []
        for task in tasks {
            switch task.status {
            case .todo:
                self.todoTasks.append(task)
            case .inProgress:
                self.inProgressTasks.append(task)
            case .completed:
                self.completedTasks.append(task)
            }
        }
    }
    
    func filtereTasks(text: String) {
        self.filteredTasks = self.mergedTasks().filter {
            return $0.title.lowercased().contains(text.lowercased())
        }
    }
    
    func removeTask(taskId: String) {
        FirestoreService.shared.removeTask(taskId: taskId) { result in
            switch result {
            case .success(let task):
                print(task)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func mergedTasks() -> [Task] {
        return self.todoTasks + self.inProgressTasks + self.completedTasks
    }
    
    func openCreateTaskViewController() {
        self.coordinator?.openCreateTaskViewController(from: self.view)
    }
    
    func openTaskViewController(task: Task) {
        self.coordinator?.openTaskViewController(from: self.view, task: task)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        self.coordinator?.openSignInViewController(from: self.view)
    }
}
