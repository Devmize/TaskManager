//
//  SignUpCoordinator.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 12.05.2023.
//

import UIKit

final class SignUpCoordinator: SignUpCoordinatorProtocol, CoordinatorProtocol {
    
    weak var view: SignUpViewProtocol?
    
    func configure() -> UIViewController {
        let signUpView = SignUpViewController()
        let signUpPresenter = SignUpPresenter()
        let signUpCoordinator = SignUpCoordinator()
        
        signUpView.presenter = signUpPresenter
        signUpPresenter.coordinator = signUpCoordinator
        signUpPresenter.view = signUpView
        signUpCoordinator.view = signUpView

        return signUpView
    }
    
    func openMainViewController(from view: SignUpViewProtocol?) {
        let nextView = TabBarCoordinator.configure()
        
        guard let vc = view as? UIViewController else { return }
        
        nextView.modalPresentationStyle = .fullScreen
        vc.present(nextView, animated: true)
    }
}
