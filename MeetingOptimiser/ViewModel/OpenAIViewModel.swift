//
//  OpenAIViewModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation
import OpenAISwift

final class OpenAIViewModel: ObservableObject {
    
    private let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    private final let MAXTOKENS: Int = 4096
    
    init() {}
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: apiKey ?? "")
    }
    
    func send(text: String, completionHandler: @escaping (String) -> ()) {
        client?.sendCompletion(with: text, maxTokens: MAXTOKENS) { result in
            switch result {
            case .success(let model):
                let output = model.choices?.first?.text ?? "Slow"
                completionHandler(output)
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
            }
        }
    }
    
}
