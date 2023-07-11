//
//  CreateTaskModuleTests.swift
//  TaskManagerTests
//
//  Created by Евгений Мизюк on 29.05.2023.
//

import XCTest
@testable import TaskManager

final class CreateTaskModuleTests: XCTestCase {

    var view: CreateTaskViewProtocol!
    var presenter: CreateTaskPresenterProtocol!
    var coordinator: CoordinatorProtocol!
    var firestoreService: FirestoreService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.view = CreateTaskViewController()
        self.presenter = CreateTaskPresenter()
        self.coordinator = CreateTaskCoordinator()
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
        let newView = self.coordinator.configure() as! CreateTaskViewProtocol
        XCTAssertNotNil(newView, "view is not nil")
        XCTAssertNotNil(newView.presenter, "presenter is not nil")
        XCTAssertNotNil(newView.presenter?.coordinator, "coordinator is not nil")
    }
    
    func testCreateTaskMethodInsideFirestoreService() {
        let task = Task(id: "12345", title: "Work", content: "Will do my job", status: .inProgress)
        self.firestoreService.saveTaskWith(task: task) { result in
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
