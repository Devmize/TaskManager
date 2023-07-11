//
//  TodoModuleTests.swift
//  TaskManagerTests
//
//  Created by Евгений Мизюк on 29.05.2023.
//

import XCTest
@testable import TaskManager

final class TodoModuleTests: XCTestCase {

    var view: TodoViewProtocol!
    var presenter: TodoPresenterProtocol!
    var coordinator: CoordinatorProtocol!
    var firestoreService: FirestoreService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.view = TodoViewController()
        self.presenter = TodoPresenter()
        self.coordinator = TodoCoordinator()
        self.firestoreService = FirestoreService.shared
    }

    override func tearDownWithError() throws {
        self.view = nil
        self.presenter = nil
        self.coordinator = nil
        self.firestoreService = nil
        try super.tearDownWithError()
    }

    func testModuleIsNotNil() {
        XCTAssertNotNil(self.view, "view is not nil")
        XCTAssertNotNil(self.presenter, "presenter is not nil")
        XCTAssertNotNil(self.coordinator, "coordinator is not nil")
        XCTAssertNotNil(self.firestoreService, "firestore service is not nil")
    }
    
    func testCoordinatorConfigureIsNotNil() {
        let newView = self.coordinator.configure() as! TodoViewProtocol
        XCTAssertNotNil(newView, "view is not nil")
        XCTAssertNotNil(newView.presenter, "presenter is not nil")
        XCTAssertNotNil(newView.presenter?.coordinator, "coordinator is not nil")
    }
    
    func testRemoveMethodInsideFirestoreService() {
        self.firestoreService.removeTask(taskId: "12345") { result in
            switch result {
            case .success(let task):
                XCTAssertEqual(task.id, "12345")
                XCTAssertEqual(task.title, "Work")
                XCTAssertEqual(task.content, "Will do my job")
                XCTAssertEqual(task.status, .inProgress)
            case .failure(let error):
                XCTAssertNil(error, "error is nil")
            }
        }
    }
}
