//
//  SignUpViewController.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 11.05.2023.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController, SignUpViewProtocol {

    var presenter: SignUpPresenterProtocol?
    
    override func loadView() {
        self.view = SignUpView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addTargets()
    }
    
    func view() -> SignUpView {
        return self.view as! SignUpView
    }
    
    private func addTargets() {
        self.view().addTapGestureToHideKeyboard()
        self.view().signUpButton.addTarget(self, action: #selector(clickSignUpButton), for: .touchUpInside)
    }
    
    @objc private func clickSignUpButton() {
        
        guard let userName = self.view().userNameTextField.text,
              let email = self.view().emailTextField.text,
              let password = self.view().passwordTextField.text,
              !userName.isEmpty, !email.isEmpty, !password.isEmpty else { return }
        
        self.presenter?.signUp(email: email, password: password, userName: userName)
    }

}
