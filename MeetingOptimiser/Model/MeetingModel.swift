//
//  MeetingModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation

struct MeetingModel: Identifiable{
    
    let id: String
    let attendees: [Employee]
    let topic: String
    let summary: String
    let summaryLength: summaryLengthEnum
    let transcript: String
    let startDate: Date
    let endDate: Date?
    let duration: Int16
    
    static let example = MeetingModel(attendees: [], topic: "Topic", summaryLength: .threeHundred, startDate: Date())
    
    init(attendees: [Employee], topic: String, summaryLength: summaryLengthEnum, startDate: Date) {
        self.id = UUID().uuidString
        self.attendees = attendees
        self.topic = topic
        self.summary = ""
        self.summaryLength = summaryLength
        self.transcript = ""
        self.startDate = startDate
        self.endDate = nil
        self.duration = 0
    }
    
    init(id: String, attendees: [Employee], topic: String, summary: String, summaryLength: summaryLengthEnum, transcript: String, startDate: Date, endDate:Date, duration: Int16) {
        self.id = id
        self.attendees = attendees
        self.topic = topic
        self.summary = summary
        self.summaryLength = summaryLength
        self.transcript = transcript
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
    }
}

enum summaryLengthEnum: Int, CaseIterable, Identifiable, Codable {
    
    var id: Self { self }
    
    case threeHundred = 300
    case fourHundred = 400
    case fiveHundred = 500
}
