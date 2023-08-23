//
//  TaskViewController.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 25.05.2023.
//

import UIKit

final class TaskViewController: UIViewController, TaskViewProtocol {
    
    var presenter: TaskPresenterProtocol?
    
    override func loadView() {
        self.view = TaskView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addTargets()
        self.uploadUIFromTask()
    }
    
    func view() -> TaskView {
        return self.view as! TaskView
    }
    
    private func addTargets() {
        self.view().addTapGestureToHideKeyboard()
        self.view().saveButton.addTarget(self, action: #selector(clickSaveButton), for: .touchUpInside)
    }
    
    internal func uploadUIFromTask() {
        self.view().titleTextField.text = self.presenter?.task?.title
        self.view().contentTextView.text = self.presenter?.task?.content
        self.view().statusTextField.text = self.presenter?.task?.status.rawValue
    }
    
    @objc func clickSaveButton() {
        let title = self.view().titleTextField.text ?? ""
        let content = self.view().contentTextView.text ?? ""
        let status = self.view().statusTextField.text!
        self.presenter?.updateTask(title: title, content: content, status: status)
    }
}
