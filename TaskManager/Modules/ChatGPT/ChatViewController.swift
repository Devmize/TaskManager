//
//  ChatViewController.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import UIKit
import SnapKit

final class ChatViewController: UIViewController, ChatViewProtocol {
    
    var presenter: ChatPresenterProtocol?
    
    private var models: [String] = []
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var inputTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Enter your message")
        textField.returnKeyType = .send
        textField.delegate = self
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.setView()
        self.addTargets()
    }
    
    private func setView() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.inputTextField)
        
        self.inputTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(48)
        }
        self.tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(self.inputTextField.snp.top)
        }
    }
    
    private func addTargets() {
        self.view.addTapGestureToHideKeyboard()
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var cellContext = cell.defaultContentConfiguration()
        cellContext.text = self.models[indexPath.row]
        cell.contentConfiguration = cellContext
        return cell
    }
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            self.models.append(text)
            ChatGPTService.shared.getResponse(input: text) { [weak self] result in
                switch result {
                case .success(let output):
                    self?.models.append(output)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        textField.text = nil
        return true
    }
}
