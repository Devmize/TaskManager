//
//  AuthError.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 11.05.2023.
//

import Foundation

enum AuthError {
    case notFilled
    case canNotUnwrapPerson
    case canNotGetPersonInfo
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("You missed field", comment: "")
        case .canNotUnwrapPerson:
            return NSLocalizedString("Can't unwrap Person from User", comment: "")
        case .canNotGetPersonInfo:
            return NSLocalizedString("Can't get Person data from Firebase", comment: "")
        }
    }
}
