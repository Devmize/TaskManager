//
//  Task.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import UIKit
import FirebaseFirestore

enum TaskStatus: String, CaseIterable {
    case todo = "Todo"
    case inProgress = "In progress"
    case completed = "Completed"
}

struct Task: Hashable {
    
    let id: String
    var title: String
    var content: String?
    var status: TaskStatus
    
    var information: [String: Any] {
        var info = ["id": self.id]
        info["title"] = self.title
        info["content"] = self.content
        info["status"] = self.status.rawValue
        return info
    }
    
    init?(document: DocumentSnapshot) {
        guard let taskData = document.data() else { return nil }
        guard let id = taskData["id"] as? String,
              let title = taskData["title"] as? String,
              let content = taskData["content"] as? String,
              let status = taskData["status"]
        else { return nil }
        
        self.id = id
        self.title = title
        self.content = content
        self.status = TaskStatus(rawValue: status as! String) ?? .todo
    }
    
    init(id: String = UUID().uuidString, title: String, content: String = "", status: TaskStatus = .todo) {
        self.id = id
        self.title = title
        self.content = content
        self.status = status
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
}
