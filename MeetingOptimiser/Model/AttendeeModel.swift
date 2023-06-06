//
//  SpeakerModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 6/6/23.
//

import Foundation

struct AttendeeModel: Identifiable {
    
    let id: String
    let attendee: EmployeeModel
    let isSpeaking: Bool
    
    init(attendee: EmployeeModel, isSpeaking: Bool) {
        self.id = attendee.id
        self.attendee = attendee
        self.isSpeaking = isSpeaking
    }
    
    init(attendee: EmployeeModel) {
        self.id = attendee.id
        self.attendee = attendee
        self.isSpeaking = false
    }
    
    static let example = AttendeeModel(attendee: .example, isSpeaking: true)
    static let example2 = AttendeeModel(attendee: .example2, isSpeaking: false)
    
    func updateIsSpeaking() -> AttendeeModel {
        return AttendeeModel(attendee: attendee, isSpeaking: !isSpeaking)
    }
}
