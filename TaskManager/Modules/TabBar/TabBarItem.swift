//
//  TabBarItem.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 12.05.2023.
//

import UIKit

enum TabBarItem {
    case todo
    case chatGPT
    
    var navTitle: String {
        switch self {
        case .todo:
            return "Todo"
        case .chatGPT:
            return "ChatGPT"
        }
    }
    
    var image: UIImage {
        switch self {
        case .todo:
            return UIImage(systemName: "list.bullet.clipboard")!
        case .chatGPT:
            return UIImage(systemName: "message")!
        }
    }
}
