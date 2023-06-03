//
//  MeetingView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 3/6/23.
//

import SwiftUI

struct MeetingView: View {
    
    @StateObject var chatgpt = OpenAIViewModel()
    @State var text = ""
    @State var models = [String]()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(models, id: \.self) { string in
                    Text(string)
                }
            }
            
            Spacer()
            
            HStack {
                TextField("Type here...", text: $text)
                Button("Send") {
                    send()
                }
            }
        }
        .onAppear {
            chatgpt.setup()
        }
        .padding()
    }
    
    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        models.append("Me: \(text)")
        chatgpt.send(text: text) { response in
            DispatchQueue.main.async {
                self.models.append("ChatGPT: " + response)
                self.text = ""
            }
        }
        
        
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
