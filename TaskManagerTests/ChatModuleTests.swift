//
//  ChatModuleTests.swift
//  TaskManagerTests
//
//  Created by Евгений Мизюк on 29.05.2023.
//

import XCTest
@testable import TaskManager

final class ChatModuleTests: XCTestCase {

    var view: ChatViewProtocol!
    var presenter: ChatPresenterProtocol!
    var coordinator: CoordinatorProtocol!
    var chatGPTService: ChatGPTService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.view = ChatViewController()
        self.presenter = ChatPresenter()
        self.coordinator = ChatCoordinator()
        self.chatGPTService = ChatGPTService.shared
    }

    override func tearDownWithError() throws {
        self.view = nil
        self.presenter = nil
        self.coordinator = nil
        self.chatGPTService = nil
        try super.tearDownWithError()
    }

    func testModuleIsNotNil() {
        XCTAssertNotNil(self.view, "view is not nil")
        XCTAssertNotNil(self.presenter, "presenter is not nil")
        XCTAssertNotNil(self.coordinator, "coordinator is not nil")
        XCTAssertNotNil(self.chatGPTService, "chatGPT service is not nil")
    }
    
    func testCoordinatorConfigureIsNotNil() {
        let newView = self.coordinator.configure() as! ChatViewProtocol
        XCTAssertNotNil(newView, "view is not nil")
        XCTAssertNotNil(newView.presenter, "presenter is not nil")
        XCTAssertNotNil(newView.presenter?.coordinator, "coordinator is not nil")
    }
    
    func testGetResponseMethodInsideChatGPTService() {
        self.chatGPTService.getResponse(input: "Say something") { result in
            switch result {
            case .success(let output):
                XCTAssertNotNil(output, "output is not nil")
            case .failure(let error):
                XCTAssertNil(error, "view is nil")
            }
        }
    }

}
