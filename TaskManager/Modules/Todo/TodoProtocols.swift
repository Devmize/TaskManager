//
//  TodoProtocols.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 12.05.2023.
//

import UIKit

protocol TodoViewProtocol: AnyObject {
    var presenter: TodoPresenterProtocol? { get set }
}

protocol TodoPresenterProtocol {
    var view: TodoViewProtocol? { get set }
    var coordinator: TodoCoordinatorProtocol? { get set }
    var todoTasks: [Task] { get set }
    var inProgressTasks: [Task] { get set }
    var completedTasks: [Task] { get set }
    var filteredTasks: [Task] { get set }
    func updateTasks(tasks: [Task])
    func mergedTasks() -> [Task]
    func filtereTasks(text: String)
    func removeTask(taskId: String)
    func openCreateTaskViewController()
    func openTaskViewController(task: Task)
    func signOut()
}

protocol TodoCoordinatorProtocol {
    var view: TodoViewProtocol? { get set }
    func openCreateTaskViewController(from view: TodoViewProtocol?)
    func openTaskViewController(from view: TodoViewProtocol?, task: Task)
    func openSignInViewController(from view: TodoViewProtocol?)
}
