//
//  SignInProtocols.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 24.04.2023.
//

import UIKit

protocol SignInViewProtocol: AnyObject {
    var presenter: SignInPresenterProtocol? { get set }
}

protocol SignInPresenterProtocol {
    var view: SignInViewProtocol? { get set }
    var coordinator: SignInCoordinatorProtocol? { get set }
    func openSignUp()
    func signIn(email: String, password: String)
}

protocol SignInCoordinatorProtocol {
    var view: SignInViewProtocol? { get set }
    func presentSignUp(from view: SignInViewProtocol?)
    func openMainViewController(from view: SignInViewProtocol?)
}
