//
//  FirestoreService.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 11.05.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirestoreService {
    
    static let shared = FirestoreService()
    
    private let database = Firestore.firestore()
    private var currentPerson: Person!
    
    func savePersonWith(id: String, email: String, userName: String, completion: @escaping (Result<Person, Error>) -> Void) {
        
        let person = Person(id: id, email: email, userName: userName)
        self.database.collection("users").document(person.id).setData(person.information) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(person))
            }
        }
    }
    
    func saveTaskWith(task: Task, completion: @escaping (Result<Task, Error>) -> Void) {
        self.database.collection("users/\(self.currentPerson.id)/tasks").document(task.id).setData(task.information) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(task))
            }
        }
    }
    
    func removeTask(taskId: String, completion: @escaping (Result<Task, Error>) -> Void) {
        
        self.database.collection("users/\(self.currentPerson.id)/tasks").document(taskId).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func getUserData(userId: String, completion: @escaping (Result<Person, Error>) -> Void) {
        let userDocRef = self.database.collection("users").document(userId)
        userDocRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let person = Person(document: document) else {
                    completion(.failure(AuthError.canNotUnwrapPerson))
                    return
                }
                self.currentPerson = person
                completion(.success(person))
            } else {
                completion(.failure(AuthError.canNotGetPersonInfo))
            }
        }
    }
}
