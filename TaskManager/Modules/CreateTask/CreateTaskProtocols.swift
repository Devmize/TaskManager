//
//  CreateTaskProtocols.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import UIKit

protocol CreateTaskViewProtocol: AnyObject {
    var presenter: CreateTaskPresenterProtocol? { get set }
}

protocol CreateTaskPresenterProtocol {
    var view: CreateTaskViewProtocol? { get set }
    var coordinator: CreateTaskCoordinatorProtocol? { get set }
    func createTask(title: String, content: String)
}

protocol CreateTaskCoordinatorProtocol {
    var view: CreateTaskViewProtocol? { get set }
    func dismissCreateTaskController()
}
