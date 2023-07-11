//
//  ChatCoordinator.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 13.05.2023.
//

import UIKit

final class ChatCoordinator: ChatCoordinatorProtocol, CoordinatorProtocol {
    
    weak var view: ChatViewProtocol?
    
    func configure() -> UIViewController {
        let chatView = ChatViewController()
        chatView.tabBarItem = UITabBarItem(title: TabBarItem.chatGPT.navTitle,
                                           image: TabBarItem.chatGPT.image,
                                           tag: 1)
        let chatPresenter = ChatPresenter()
        let chatCoordinator = ChatCoordinator()
        
        chatView.presenter = chatPresenter
        chatPresenter.coordinator = chatCoordinator
        chatPresenter.view = chatView
        chatCoordinator.view = chatView

        return chatView
    }
}
