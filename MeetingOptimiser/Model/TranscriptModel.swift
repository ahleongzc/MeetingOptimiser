//
//  TranscriptModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 9/6/23.
//

import Foundation

struct TranscriptModel: Identifiable {
    
    let id: String
    let transcript: String
    let speaker: EmployeeModel
    let duration: Int
    let startTime: Date
    
    init(transcript: String, speaker: EmployeeModel, duration: Int, startTime: Date) {
        self.id = UUID().uuidString
        self.transcript = transcript
        self.speaker = speaker
        self.duration = duration
        self.startTime = startTime
    }
    
    init(transcript: Transcript) {
        self.id = transcript.id ?? "Id"
        self.transcript = transcript.transcript ?? "Transcript"
        
        if let emp = transcript.employee {
            self.speaker = EmployeeModel(employee: emp)
        } else {
            self.speaker = EmployeeModel.example
        }
        
        self.duration = Int(transcript.duration)
        self.startTime = transcript.startTime ?? Date()
    }
    
    static let example = TranscriptModel(transcript: "This is an example transcript by speaker 1", speaker: .example, duration: 10, startTime: Date())
    static let example2 = TranscriptModel(transcript: "This is the second example transcript by speaker 2", speaker: .example2, duration: 10, startTime: Date())
}
