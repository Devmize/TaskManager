//
//  CreateTaskViewController.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import UIKit

final class CreateTaskViewController: UIViewController, CreateTaskViewProtocol {
    
    var presenter: CreateTaskPresenterProtocol?
    
    override func loadView() {
        self.view = CreateTaskView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addTargets()
    }
    
    func view() -> CreateTaskView {
        return self.view as! CreateTaskView
    }
    
    private func addTargets() {
        self.view().addTapGestureToHideKeyboard()
        self.view().createButton.addTarget(self, action: #selector(clickCreateButton), for: .touchUpInside)
    }
    
    @objc func clickCreateButton() {
        guard let title = self.view().titleTextField.text,
              let content = self.view().contentTextView.text,
              !title.isEmpty else { return }
        
        self.presenter?.createTask(title: title, content: content)
    }

}
