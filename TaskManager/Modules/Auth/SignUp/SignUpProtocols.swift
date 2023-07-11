//
//  SignUpProtocols.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 11.05.2023.
//

import UIKit

protocol SignUpViewProtocol: AnyObject {
    var presenter: SignUpPresenterProtocol? { get set }
}

protocol SignUpPresenterProtocol {
    var view: SignUpViewProtocol? { get set }
    var coordinator: SignUpCoordinatorProtocol? { get set }
    func signUp(email: String, password: String, userName: String)
}

protocol SignUpCoordinatorProtocol {
    var view: SignUpViewProtocol? { get set }
    func openMainViewController(from view: SignUpViewProtocol?)
}
