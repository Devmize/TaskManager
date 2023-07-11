//
//  ViewController.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 24.04.2023.
//

import UIKit
import SnapKit

final class SignInViewController: UIViewController, SignInViewProtocol {
    
    private(set) lazy var signInView = SignInView()
    
    var presenter: SignInPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setView()
        self.addTargets()
    }
    
    private func setView() {
        self.view.addSubview(self.signInView)
        
        self.signInView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addTargets() {
        self.signInView.addTapGestureToHideKeyboard()
        self.signInView.signInButton.addTarget(self, action: #selector(clickSignInButton), for: .touchUpInside)
        self.signInView.signUpButton.addTarget(self, action: #selector(clickSignUpButton), for: .touchUpInside)
    }
    
    @objc func clickSignInButton() {
        guard let email = self.signInView.emailTextField.text,
              let password = self.signInView.passwordTextField.text, !email.isEmpty, !password.isEmpty else { return }
        
        self.presenter?.signIn(email: email, password: password)
    }
    
    @objc func clickSignUpButton() {
        self.presenter?.openSignUp()
    }

}

