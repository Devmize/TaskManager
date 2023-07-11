//
//  Person.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 11.05.2023.
//

import Foundation
import FirebaseFirestore

struct Person: Hashable {
    
    let id: String
    let email: String
    let userName: String
    
    var information: [String: Any] {
        var info = ["id": self.id]
        info["email"] = self.email
        info["userName"] = self.userName
        return info
    }
    
    init?(document: DocumentSnapshot) {
        guard let personData = document.data() else { return nil }
        guard let id = personData["id"] as? String,
              let email = personData["email"] as? String,
              let userName = personData["userName"] as? String else { return nil }
        
        self.userName = userName
        self.email = email
        self.id = id
    }
    
    init(id: String, email: String, userName: String) {
        self.userName = userName
        self.email = email
        self.id = id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
