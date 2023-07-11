//
//  TaskModuleTests.swift
//  TaskManagerTests
//
//  Created by Евгений Мизюк on 29.05.2023.
//

import XCTest
@testable import TaskManager

final class TaskModuleTests: XCTestCase {

    var view: TaskViewProtocol!
    var presenter: TaskPresenterProtocol!
    var coordinator: CoordinatorProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.view = TaskViewController()
        self.presenter = TaskPresenter()
        self.coordinator = TaskCoordinator()
    }

    override func tearDownWithError() throws {
        self.view = nil
        self.presenter = nil
        self.coordinator = nil
        try super.tearDownWithError()
    }

    func testModuleIsNotNil() {
        XCTAssertNotNil(self.view, "view is not nil")
        XCTAssertNotNil(self.presenter, "presenter is not nil")
        XCTAssertNotNil(self.coordinator, "coordinator is not nil")
    }
    
    func testCoordinatorConfigureIsNotNil() {
        let newView = self.coordinator.configure() as! TaskViewProtocol
        XCTAssertNotNil(newView, "view is not nil")
        XCTAssertNotNil(newView.presenter, "presenter is not nil")
        XCTAssertNotNil(newView.presenter?.coordinator, "coordinator is not nil")
    }
}
