//
//  TaskProtocols.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 25.05.2023.
//

import UIKit

protocol TaskViewProtocol: AnyObject {
    var presenter: TaskPresenterProtocol? { get set }
    func uploadUIFromTask()
}

protocol TaskPresenterProtocol {
    var view: TaskViewProtocol? { get set }
    var coordinator: TaskCoordinatorProtocol? { get set }
    var task: Task? { get set }
    func updateTask(title: String, content: String, status: String)
}

protocol TaskCoordinatorProtocol {
    var view: TaskViewProtocol? { get set }
    func configureWith(task: Task) -> UIViewController
    func dismissTaskController()
}
