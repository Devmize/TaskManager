//
//  CreateTaskViewController.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import UIKit

final class CreateTaskViewController: UIViewController, CreateTaskViewProtocol {
    
    private lazy var taskView = CreateTaskView()
    
    var presenter: CreateTaskPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setView()
        self.addTargets()
    }
    
    private func setView() {
        self.view.addSubview(self.taskView)
        
        self.taskView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addTargets() {
        self.taskView.addTapGestureToHideKeyboard()
        self.taskView.createButton.addTarget(self, action: #selector(clickCreateButton), for: .touchUpInside)
    }
    
    @objc func clickCreateButton() {
        guard let title = self.taskView.titleTextField.text,
              let content = self.taskView.contentTextView.text,
              !title.isEmpty else { return }
        
        self.presenter?.createTask(title: title, content: content)
    }

}
