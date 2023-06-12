//
//  TranscriptModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 9/6/23.
//

import Foundation

struct TranscriptModel: Identifiable {
    
    let id: String = UUID().uuidString
    let transcript: String
    let speaker: EmployeeModel
    let duration: Int
    let startTime: Date
    
    init(transcript: String, speaker: EmployeeModel, duration: Int, startTime: Date) {
        self.transcript = transcript
        self.speaker = speaker
        self.duration = duration
        self.startTime = startTime
    }
    
    static let example = TranscriptModel(transcript: "This is an example transcript", speaker: .example, duration: 10, startTime: Date())
}
