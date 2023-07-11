//
//  TaskViewController.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 25.05.2023.
//

import UIKit

final class TaskViewController: UIViewController, TaskViewProtocol {
    
    private lazy var taskView = TaskView()
    
    var presenter: TaskPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setView()
        self.addTargets()
        self.uploadUIFromTask()
    }

    private func setView() {
        self.view.addSubview(self.taskView)
        
        self.taskView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addTargets() {
        self.taskView.addTapGestureToHideKeyboard()
        self.taskView.saveButton.addTarget(self, action: #selector(clickSaveButton), for: .touchUpInside)
    }
    
    internal func uploadUIFromTask() {
        self.taskView.titleTextField.text = self.presenter?.task?.title
        self.taskView.contentTextView.text = self.presenter?.task?.content
        self.taskView.statusTextField.text = self.presenter?.task?.status.rawValue
    }
    
    @objc func clickSaveButton() {
        let title = self.taskView.titleTextField.text ?? ""
        let content = self.taskView.contentTextView.text ?? ""
        let status = self.taskView.statusTextField.text!
        self.presenter?.updateTask(title: title, content: content, status: status)
    }
}
