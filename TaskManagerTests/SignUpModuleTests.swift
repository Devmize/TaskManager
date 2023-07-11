//
//  SignUpModuleTests.swift
//  SignUpModeleTests
//
//  Created by Евгений Мизюк on 28.05.2023.
//

import XCTest
@testable import TaskManager

final class SignUpModuleTests: XCTestCase {
    
    var view: SignUpViewProtocol!
    var presenter: SignUpPresenterProtocol!
    var coordinator: CoordinatorProtocol!
    var authService: AuthService!
    var firestoreService: FirestoreService!
    var person: Person!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.view = SignUpViewController()
        self.presenter = SignUpPresenter()
        self.coordinator = SignUpCoordinator()
        self.authService = AuthService.shared
        self.firestoreService = FirestoreService.shared
        self.person = Person(id: "12345", email: "devmize@gmail.com", userName: "Eugene")
    }

    override func tearDownWithError() throws {
        self.view = nil
        self.presenter = nil
        self.coordinator = nil
        self.person = nil
        self.authService = nil
        self.firestoreService = nil
        try super.tearDownWithError()
    }

    func testModuleIsNotNil() {
        XCTAssertNotNil(self.view, "view is not nil")
        XCTAssertNotNil(self.presenter, "presenter is not nil")
        XCTAssertNotNil(self.coordinator, "coordinator is not nil")
        XCTAssertNotNil(self.person, "person is not nil")
        XCTAssertNotNil(self.authService, "auth service is not nil")
        XCTAssertNotNil(self.firestoreService, "firestore service is not nil")
    }
    
    func testCoordinatorConfigureIsNotNil() {
        let newView = self.coordinator.configure() as! SignUpViewProtocol
        XCTAssertNotNil(newView, "view is not nil")
        XCTAssertNotNil(newView.presenter, "presenter is not nil")
        XCTAssertNotNil(newView.presenter?.coordinator, "coordinator is not nil")
    }
    
    func testPersonModel() {
        XCTAssertEqual(self.person.id, "12345")
        XCTAssertEqual(self.person.email, "devmize@gmail.com")
        XCTAssertEqual(self.person.userName, "Eugene")
    }
    
    func testRegisterMethodInsideAuthServiceWithCorrectData() {
        self.authService.register(email: "ultramultik@gmail.com", password: "multik12345") { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.email, "ultramultik@gmail.com")
            case .failure(let error):
                XCTAssertNil(error, "error is nil")
            }
        }
    }
    
    func testRegisterMethodInsideAuthServiceWithIncorrectEmail() {
        self.authService.register(email: "", password: "multik12345") { result in
            switch result {
            case .success(let user):
                XCTAssertNil(user, "user is nil")
            case .failure(let error):
                XCTAssertNotNil(error, "error is not nil")
            }
        }
    }
    
    func testRegisterMethodInsideAuthServiceWithIncorrectPassword() {
        self.authService.register(email: "ultramutlik@gmail.com", password: "") { result in
            switch result {
            case .success(let user):
                XCTAssertNil(user, "user is nil")
            case .failure(let error):
                XCTAssertNotNil(error, "error is not nil")
            }
        }
    }
    
    func testSaveUserIndiseFirestoreService() {
        self.firestoreService.savePersonWith(id: "123456789", email: "ultramultik@gmail.com", userName: "Eugene") { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.id, "123456789")
                XCTAssertEqual(user.email, "ultramultik@gmail.com")
                XCTAssertEqual(user.userName, "Eugene")
            case .failure(let error):
                XCTAssertNil(error, "error is nil")
            }
        }
    }
}
