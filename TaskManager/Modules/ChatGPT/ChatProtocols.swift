//
//  ChatProtocols.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import UIKit

protocol ChatViewProtocol: AnyObject {
    var presenter: ChatPresenterProtocol? { get set }
}

protocol ChatPresenterProtocol {
    var view: ChatViewProtocol? { get set }
    var coordinator: ChatCoordinatorProtocol? { get set }
}

protocol ChatCoordinatorProtocol {
    var view: ChatViewProtocol? { get set }
}
