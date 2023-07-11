//
//  SignUpViewController.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 11.05.2023.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController, SignUpViewProtocol {
    
    private(set) lazy var signUpView = SignUpView()
    var presenter: SignUpPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setView()
        self.addTargets()
    }
    
    private func setView() {
        self.view.addSubview(self.signUpView)
        
        self.signUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addTargets() {
        self.signUpView.addTapGestureToHideKeyboard()
        self.signUpView.signUpButton.addTarget(self, action: #selector(clickSignUpButton), for: .touchUpInside)
    }
    
    @objc private func clickSignUpButton() {
        
        guard let userName = self.signUpView.userNameTextField.text,
              let email = self.signUpView.emailTextField.text,
              let password = self.signUpView.passwordTextField.text,
              !userName.isEmpty, !email.isEmpty, !password.isEmpty else { return }
        
        self.presenter?.signUp(email: email, password: password, userName: userName)
    }

}
