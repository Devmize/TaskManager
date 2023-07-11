//
//  CreateTaskView.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import UIKit

final class CreateTaskView: UIView {
    
    private(set) lazy var backView: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .init(named: "TextColor")
        return label
    }()
    
    private(set) lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Content"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .init(named: "TextColor")
        return label
    }()
    
    private(set) lazy var titleTextField: UITextField = {
        let textField = CustomTextField(placeholder: "")
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        return textField
    }()
    
    private(set) lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .black
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    private(set) lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
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
        self.backView.addSubview(self.titleTextField)
        self.backView.addSubview(self.contentLabel)
        self.backView.addSubview(self.contentTextView)
        self.backView.addSubview(self.createButton)
    }
    
    private func setConstraints() {
        self.backView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        self.contentTextView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(300)
        }
        self.contentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.contentTextView.snp.top).offset(-5)
            make.leading.equalTo(self.contentTextView.snp.leading).offset(3)
        }
        self.titleTextField.snp.makeConstraints { make in
            make.bottom.equalTo(self.contentLabel.snp.top).offset(-10)
            make.leading.equalTo(self.contentTextView.snp.leading)
            make.trailing.equalTo(self.contentTextView.snp.trailing)
            make.height.equalTo(48)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.titleTextField.snp.leading).inset(3)
            make.bottom.equalTo(self.titleTextField.snp.top).offset(-5)
        }
        self.createButton.snp.makeConstraints { make in
            make.top.equalTo(self.contentTextView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
    }


}
