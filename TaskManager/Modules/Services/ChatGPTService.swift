//
//  ChatGPTService.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 14.05.2023.
//

import Foundation
import OpenAI

final class ChatGPTService {
    
    static let shared = ChatGPTService()
    
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client = OpenAI(apiToken: Constants.key)
    
    func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let query = ChatQuery(model: .gpt3_5Turbo, messages: [.init(role: .user, content: input)])
        
        self.client.chats(query: query) { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.message.content ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
