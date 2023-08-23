//
//  ViewController.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 24.04.2023.
//

import UIKit
import SnapKit

final class SignInViewController: UIViewController, SignInViewProtocol {
    
    var presenter: SignInPresenterProtocol?
    
    override func loadView() {
        self.view = SignInView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addTargets()
    }
    
    func view() -> SignInView {
        return self.view as! SignInView
    }

    private func addTargets() {
        self.view().addTapGestureToHideKeyboard()
        self.view().signInButton.addTarget(self, action: #selector(clickSignInButton), for: .touchUpInside)
        self.view().signUpButton.addTarget(self, action: #selector(clickSignUpButton), for: .touchUpInside)
    }
    
    @objc func clickSignInButton() {
        guard let email = self.view().emailTextField.text,
              let password = self.view().passwordTextField.text, !email.isEmpty, !password.isEmpty else { return }
        
        self.presenter?.signIn(email: email, password: password)
    }
    
    @objc func clickSignUpButton() {
        self.presenter?.openSignUp()
    }

}

