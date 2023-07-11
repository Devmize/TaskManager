//
//  SignUpView.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 11.05.2023.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    private(set) lazy var backView: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sixhands"
        label.font = .systemFont(ofSize: 46, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private(set) lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .init(named: "TextColor")
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
    
    private(set) lazy var repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Repeat password"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .init(named: "TextColor")
        return label
    }()
    
    private(set) lazy var userNameTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Enter name")
        return textField
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Enter email")
        return textField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Enter password")
        return textField
    }()
    
    private(set) lazy var repeatPasswordTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Enter password")
        return textField
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = .black
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
        self.addSubview(self.backView)
        
        self.backView.addSubview(self.titleLabel)
        self.backView.addSubview(self.userNameLabel)
        self.backView.addSubview(self.userNameTextField)
        self.backView.addSubview(self.emailTextField)
        self.backView.addSubview(self.emailLabel)
        self.backView.addSubview(self.passwordLabel)
        self.backView.addSubview(self.passwordTextField)
        self.backView.addSubview(self.repeatPasswordLabel)
        self.backView.addSubview(self.repeatPasswordTextField)
        self.backView.addSubview(self.signUpButton)
    }
    
    private func setConstraints() {
        self.backView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        self.userNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(100)
            make.height.equalTo(48)
        }
        self.userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.userNameTextField.snp.leading).offset(3)
            make.bottom.equalTo(self.userNameTextField.snp.top).offset(-5)
        }
        self.emailLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.userNameTextField.snp.leading).offset(3)
            make.top.equalTo(self.userNameTextField.snp.bottom).offset(15)
        }
        self.emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(self.userNameTextField.snp.leading)
            make.trailing.equalTo(self.userNameTextField.snp.trailing)
            make.top.equalTo(self.emailLabel.snp.bottom).offset(5)
            make.height.equalTo(48)
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
        self.repeatPasswordLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.passwordTextField.snp.leading).offset(3)
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
        }
        self.repeatPasswordTextField.snp.makeConstraints { make in
            make.leading.equalTo(self.passwordTextField.snp.leading)
            make.trailing.equalTo(self.passwordTextField.snp.trailing)
            make.top.equalTo(self.repeatPasswordLabel.snp.bottom).offset(5)
            make.height.equalTo(48)
        }
        self.signUpButton.snp.makeConstraints { make in
            make.top.equalTo(self.repeatPasswordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
    }

}
