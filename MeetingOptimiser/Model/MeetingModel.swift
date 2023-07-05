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
    let summary: String?
    let transcripts: [TranscriptModel]?
    let startDate: Date?
    let endDate: Date?
    let duration: Int

    static let example = MeetingModel(attendees: [.example, .example2], topic: "This is an example topic")
    static let example2 = MeetingModel(id: UUID().uuidString, attendees: [.example, .example2], topic: "This is an example topic", summary: "This is a 300 word summary of the meeting", transcripts: [.example, .example2], startDate: Date(), endDate: Date())
    
    
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
        self.duration = Int(meeting.duration)
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
    
    init(id: String, attendees: [EmployeeModel], topic: String, summary: String, transcripts: [TranscriptModel], startDate: Date, endDate:Date) {
        self.id = id
        self.attendees = attendees
        self.topic = topic
        self.summary = summary
        self.transcripts = transcripts
        self.startDate = startDate
        self.endDate = endDate
        self.duration = Int(endDate.timeIntervalSince(startDate))
    }
    
    init(id: String, attendees: [EmployeeModel], topic: String, transcripts: [TranscriptModel], startDate: Date, endDate:Date) {
        self.id = id
        self.attendees = attendees
        self.topic = topic
        self.summary = nil
        self.transcripts = transcripts
        self.startDate = startDate
        self.endDate = endDate
        self.duration = Int(endDate.timeIntervalSince(startDate))
    }
    
    func updateMeeting(_ transcripts: [TranscriptModel], startDate: Date) -> MeetingModel {
        return MeetingModel(id: id, attendees: attendees, topic: topic, transcripts: transcripts, startDate: startDate, endDate: Date())
    }
    
    func updateSummary(summary: String) -> MeetingModel {
        return MeetingModel(id: id, attendees: attendees, topic: topic, summary: summary, transcripts: transcripts ?? [], startDate: startDate ?? Date(), endDate: endDate ?? Date())
    }
}
