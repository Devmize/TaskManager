//
//  SignUpPresenter.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 11.05.2023.
//

import UIKit

final class SignUpPresenter: SignUpPresenterProtocol {
    
    weak var view: SignUpViewProtocol?
    var coordinator: SignUpCoordinatorProtocol?
    
    func signUp(email: String, password: String, userName: String) {
        
        AuthService.shared.register(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                FirestoreService.shared.savePersonWith(id: user.uid,
                                                       email: user.email!,
                                                       userName: userName) { result in
                    switch result {
                    case .success(let person):
                        self.coordinator?.openMainViewController(from: self.view)
                        print(person)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
