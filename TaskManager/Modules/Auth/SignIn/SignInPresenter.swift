//
//  SignInPresenter.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 24.04.2023.
//

import UIKit

final class SignInPresenter: SignInPresenterProtocol {
    
    weak var view: SignInViewProtocol?
    var coordinator: SignInCoordinatorProtocol?
    
    func signIn(email: String, password: String) {
        AuthService.shared.login(email: email,
                                 password: password) { result in
            switch result {
                case .success(let user):
                FirestoreService.shared.getUserData(userId: user.uid) { result in
                    switch result {
                        case .success(let user):
                        self.coordinator?.openMainViewController(from: self.view)
                        print(user)
                        case .failure(let error):
                        print(error)
                        }
                }
                case .failure(let error):
                print(error)
            }
        }
    }
    
    func openSignUp() {
        self.coordinator?.presentSignUp(from: self.view)
    }
}
