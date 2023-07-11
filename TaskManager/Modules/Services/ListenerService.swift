//
//  ListenerService.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import FirebaseAuth
import FirebaseFirestore

final class ListenerService {
    
    static let shared = ListenerService()
    
    private let dataBase = Firestore.firestore()
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    func tasksObserve(tasks: [Task], completion: @escaping (Result<[Task], Error>) -> Void) -> ListenerRegistration? {
        var tasks = tasks
        let tasksRef = self.dataBase.collection(["users", self.currentUserId, "tasks"].joined(separator: "/"))
        let tasksListener = tasksRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            snapshot.documentChanges.forEach { diff in
                guard let task = Task(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !tasks.contains(task) else { return }
                    tasks.append(task)
                case .modified:
                    guard let index = tasks.firstIndex(of: task) else { return }
                    tasks[index] = task
                case .removed:
                    guard let index = tasks.firstIndex(of: task) else { return }
                    tasks.remove(at: index)
                }
            }
            completion(.success(tasks))
        }
        
        return tasksListener
    }
    
}
