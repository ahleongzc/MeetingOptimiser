//
//  MeetingModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation

struct MeetingModel: Identifiable {
    
    let id: String
    let attendees: [EmployeeModel]
    let topic: String
    let summary: String
    let transcripts: [TranscriptModel]?
    let startDate: Date?
    let endDate: Date?
    let duration: Int16

    static let example = MeetingModel(attendees: [.example, .example2], topic: "This is an example topic")
    
    init(meeting: Meeting) {
        self.id = meeting.id ?? "Id"
        
        var tempAttendees = [EmployeeModel]()
        for emp in meeting.employee ?? [] {
            if let emp = emp as? Employee {
                tempAttendees.append(EmployeeModel(employee: emp))
            }
        }
        
        self.attendees = tempAttendees
        
        var tempTranscripts = [TranscriptModel]()
        for transcript in meeting.transcript ?? [] {
            if let transcript = transcript as? Transcript {
                tempTranscripts.append(TranscriptModel(transcript: transcript))
            }
        }
        
        self.transcripts = tempTranscripts
        
        self.topic = meeting.topic ?? "Topic"
        self.summary = meeting.summary ?? "Summary"
        self.startDate = meeting.startDate ?? Date()
        self.endDate = meeting.endDate ?? Date()
        self.duration = meeting.duration
    }
    
    init(attendees: [EmployeeModel], topic: String) {
        self.id = UUID().uuidString
        self.attendees = attendees
        self.topic = topic
        self.summary = ""
        self.transcripts = nil
        self.startDate = nil
        self.endDate = nil
        self.duration = 0
    }
    
    init(id: String, attendees: [EmployeeModel], topic: String, summary: String, transcripts: [TranscriptModel], startDate: Date, endDate:Date, duration: Int) {
        self.id = id
        self.attendees = attendees
        self.topic = topic
        self.summary = summary
        self.transcripts = transcripts
        self.startDate = startDate
        self.endDate = endDate
        self.duration = Int16(endDate.timeIntervalSince(startDate))
    }
    
    func updateMeeting(_ transcripts: [TranscriptModel], startDate: Date) -> MeetingModel {
        return MeetingModel(id: id, attendees: attendees, topic: topic, summary: summary, transcripts: transcripts, startDate: startDate, endDate: Date(), duration: 0)
    }
}
