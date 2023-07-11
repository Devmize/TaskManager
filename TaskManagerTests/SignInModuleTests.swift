//
//  SignInModuleTests.swift
//  SignInModuleTests
//
//  Created by Евгений Мизюк on 29.05.2023.
//

import XCTest
@testable import TaskManager

final class SignInModuleTests: XCTestCase {

    var view: SignInViewProtocol!
    var presenter: SignInPresenterProtocol!
    var coordinator: CoordinatorProtocol!
    var authService: AuthService!
    var firestoreService: FirestoreService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.view = SignInViewController()
        self.presenter = SignInPresenter()
        self.coordinator = SignInCoordinator()
        self.authService = AuthService.shared
        self.firestoreService = FirestoreService.shared
    }

    override func tearDownWithError() throws {
        self.view = nil
        self.presenter = nil
        self.coordinator = nil
        self.authService = nil
        self.firestoreService = nil
        try super.tearDownWithError()
    }

    func testModuleIsNotNil() {
        XCTAssertNotNil(self.view, "view is not nil")
        XCTAssertNotNil(self.presenter, "presenter is not nil")
        XCTAssertNotNil(self.coordinator, "coordinator is not nil")
        XCTAssertNotNil(self.authService, "auth service is not nil")
        XCTAssertNotNil(self.firestoreService, "firestore service is not nil")
    }
    
    func testCoordinatorConfigureIsNotNil() {
        let newView = self.coordinator.configure() as! SignInViewProtocol
        XCTAssertNotNil(newView, "view is not nil")
        XCTAssertNotNil(newView.presenter, "presenter is not nil")
        XCTAssertNotNil(newView.presenter?.coordinator, "coordinator is not nil")
    }
    
    func testLoginMethodInsideAuthServiceWithCorrectData() {
        self.authService.login(email: "ultramultik@gmail.com", password: "multik12345") { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.email, "ultramultik@gmail.com")
            case .failure(let error):
                XCTAssertNil(error, "error is nil")
            }
        }
    }
    
    func testLoginMethodInsideAuthServiceWithIncorrectEmail() {
        self.authService.login(email: "ultramultik", password: "multik12345") { result in
            switch result {
            case .success(let user):
                XCTAssertNil(user, "user is nil")
            case .failure(let error):
                XCTAssertNotNil(error, "error is not nil")
            }
        }
    }
    
    func testLoginMethodInsideAuthServiceWithIncorrectPassword() {
        self.authService.login(email: "ultramultik@gmail.com", password: "") { result in
            switch result {
            case .success(let user):
                XCTAssertNil(user, "user is nil")
            case .failure(let error):
                XCTAssertNotNil(error, "error is not nil")
            }
        }
    }
    
    func testGetUserDataMethodInsideFirestoreService() {
        self.firestoreService.getUserData(userId: "123456789") { result in
            switch result {
            case .success(let user):
                XCTAssertNotNil(user, "user is not nil")
            case .failure(let error):
                XCTAssertNil(error, "error is nil")
            }
        }
    }
}
