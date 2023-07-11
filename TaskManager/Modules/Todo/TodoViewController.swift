//
//  TodoViewController.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 12.05.2023.
//

import UIKit
import FirebaseFirestore

final class TodoViewController: UIViewController, TodoViewProtocol {
    
    var presenter: TodoPresenterProtocol?
    private var tasksListener: ListenerRegistration?
    
    let groupTitleForSection: [String] = [TaskStatus.todo.rawValue, TaskStatus.inProgress.rawValue, TaskStatus.completed.rawValue]
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private lazy var searchController: UISearchController = {
            let sc = UISearchController()
            sc.searchBar.delegate = self
            sc.searchResultsUpdater = self
            sc.searchBar.placeholder = "Search"
            return sc
        }()
    
    private var isFiltering: Bool {
        return searchController.isActive && searchController.searchBar.text! != ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.setView()
        
        self.tasksListener = ListenerService.shared.tasksObserve(tasks: self.presenter?.mergedTasks() ?? [], completion: { result in
            switch result {
            case .success(let tasks):
                self.presenter?.updateTasks(tasks: tasks)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    deinit {
        self.tasksListener?.remove()
    }
    
    private func setView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addTaskClickButton))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.left"), style: .plain, target: self, action: #selector(exitClickButton))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func addTaskClickButton() {
        self.presenter?.openCreateTaskViewController()
    }
    
    @objc private func exitClickButton() {
        self.presenter?.signOut()
    }
}

extension TodoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.isFiltering {
            return "Found tasks"
        }
        return self.groupTitleForSection[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.isFiltering {
            return 1
        }
        return self.groupTitleForSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltering {
            return self.presenter?.filteredTasks.count ?? 0
        }
        switch section {
        case 0:
            return self.presenter?.todoTasks.count ?? 0
        case 1:
            return self.presenter?.inProgressTasks.count ?? 0
        case 2:
            return self.presenter?.completedTasks.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        var cellContext = cell.defaultContentConfiguration()
        if isFiltering {
            cellContext.text = self.presenter?.filteredTasks[indexPath.row].title
            cell.contentConfiguration = cellContext
            return cell
        }
        switch indexPath.section {
        case 0:
            cellContext.text = self.presenter?.todoTasks[indexPath.row].title
        case 1:
            cellContext.text = self.presenter?.inProgressTasks[indexPath.row].title
        case 2:
            cellContext.text = self.presenter?.completedTasks[indexPath.row].title
        default:
            cellContext.text = "none"
        }
        cell.contentConfiguration = cellContext
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { [weak self] _, _, completionHandler in
                var taskId = ""
                switch indexPath.section {
                case 0:
                    taskId = self?.presenter?.todoTasks[indexPath.row].id ?? ""
                case 1:
                    taskId = self?.presenter?.inProgressTasks[indexPath.row].id ?? ""
                case 2:
                    taskId = self?.presenter?.completedTasks[indexPath.row].id ?? ""
                default:
                    break
                }
                self?.presenter?.removeTask(taskId: taskId)
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let task = self.presenter?.todoTasks[indexPath.row] else { return }
            self.presenter?.openTaskViewController(task: task)
        case 1:
            guard let task = self.presenter?.inProgressTasks[indexPath.row] else { return }
            self.presenter?.openTaskViewController(task: task)
        case 2:
            guard let task = self.presenter?.completedTasks[indexPath.row] else { return }
            self.presenter?.openTaskViewController(task: task)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension TodoViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            searchBar.endEditing(true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
            
        self.presenter?.filtereTasks(text: searchController.searchBar.text!)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
