//
//  SignInCoordinator.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 12.05.2023.
//

import UIKit

final class SignInCoordinator: SignInCoordinatorProtocol, CoordinatorProtocol {
    
    weak var view: SignInViewProtocol?
    
    func configure() -> UIViewController {
        let signInView = SignInViewController()
        let signInPresenter = SignInPresenter()
        let signInCoordinator = SignInCoordinator()
        
        signInView.presenter = signInPresenter
        signInPresenter.coordinator = signInCoordinator
        signInPresenter.view = signInView
        signInCoordinator.view = signInView

        return signInView
    }
    
    func presentSignUp(from view: SignInViewProtocol?) {
        let nextView = SignUpCoordinator().configure()
        
        guard let vc = view as? UIViewController else { return }

        nextView.modalPresentationStyle = .fullScreen
        vc.present(nextView, animated: true)
    }
    
    func openMainViewController(from view: SignInViewProtocol?) {
        let nextView = TabBarCoordinator.configure()
        
        guard let vc = view as? UIViewController else { return }
        
        nextView.modalPresentationStyle = .fullScreen
        vc.present(nextView, animated: true)
    }
    
}
