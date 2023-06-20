//
//  MeetingModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation

struct MeetingModel: Identifiable {
    
    let id: String = UUID().uuidString
    let attendees: [EmployeeModel]
    let topic: String
    let summary: String
    let summaryLength: summaryLengthEnum
    let transcripts: [TranscriptModel]?
    let startDate: Date?
    let endDate: Date?
    let duration: Int

    static let example = MeetingModel(attendees: [.example, .example2], topic: "This is an example topic", summaryLength: .threeHundred)
    
    init(attendees: [EmployeeModel], topic: String, summaryLength: summaryLengthEnum) {
        self.attendees = attendees
        self.topic = topic
        self.summary = ""
        self.summaryLength = summaryLength
        self.transcripts = nil
        self.startDate = nil
        self.endDate = nil
        self.duration = 0
    }
    
    init(id: String, attendees: [EmployeeModel], topic: String, summary: String, summaryLength: summaryLengthEnum, transcripts: [TranscriptModel], startDate: Date, endDate:Date, duration: Int) {
        self.attendees = attendees
        self.topic = topic
        self.summary = summary
        self.summaryLength = summaryLength
        self.transcripts = transcripts
        self.startDate = startDate
        self.endDate = endDate
        self.duration = Int(endDate.timeIntervalSince(startDate))
    }
    
    func updateMeeting(_ transcripts: [TranscriptModel], startDate: Date) -> MeetingModel {
        return MeetingModel(id: id, attendees: attendees, topic: topic, summary: summary, summaryLength: summaryLength, transcripts: transcripts, startDate: startDate, endDate: Date(), duration: 0)
    }
}

enum summaryLengthEnum: Int, CaseIterable, Identifiable, Codable {
    
    var id: Self { self }
    
    case threeHundred = 300
    case fourHundred = 400
    case fiveHundred = 500
}
