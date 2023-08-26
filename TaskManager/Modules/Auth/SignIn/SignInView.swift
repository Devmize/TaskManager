//
//  SingInView.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 24.04.2023.
//

import UIKit
import SnapKit

final class SignInView: UIView {
    
    private(set) lazy var backView: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Shell"
        label.font = .systemFont(ofSize: 46, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private(set) lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .init(named: "TextColor")
        return label
    }()
    
    private(set) lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .init(named: "TextColor")
        return label
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Enter email")
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        return textField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Enter password")
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        return textField
    }()
    
    private(set) lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = .black
        button.layer.cornerRadius = 7
        return button
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.layer.cornerRadius = 7
        return button
    }()

    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.addSubviews()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.backView)
        
        self.backView.addSubview(self.titleLabel)
        self.backView.addSubview(self.emailTextField)
        self.backView.addSubview(self.emailLabel)
        self.backView.addSubview(self.passwordLabel)
        self.backView.addSubview(self.passwordTextField)
        self.backView.addSubview(self.signInButton)
        self.backView.addSubview(self.signUpButton)
    }
    
    private func setConstraints() {
        self.scrollView.snp.makeConstraints { make in
            make.center.top.bottom.leading.trailing.equalToSuperview()
        }
        self.backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(150)
        }
        self.emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(100)
            make.height.equalTo(48)
        }
        self.emailLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.emailTextField.snp.leading).offset(3)
            make.bottom.equalTo(self.emailTextField.snp.top).offset(-5)
        }
        self.passwordLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.emailTextField.snp.leading).offset(3)
            make.top.equalTo(self.emailTextField.snp.bottom).offset(15)
        }
        self.passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(self.emailTextField.snp.leading)
            make.trailing.equalTo(self.emailTextField.snp.trailing)
            make.top.equalTo(self.passwordLabel.snp.bottom).offset(5)
            make.height.equalTo(48)
        }
        self.signInButton.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        self.signUpButton.snp.makeConstraints { make in
            make.top.equalTo(self.signInButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

}
