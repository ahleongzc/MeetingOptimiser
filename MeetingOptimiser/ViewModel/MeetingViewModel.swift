//
//  MeetingsViewModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation
import SwiftUI

@MainActor
class MeetingViewModel: ObservableObject {
    
    // let attendees: [Employee]
    @Published var topic: String = ""
    //    let summary: String
    @Published var summaryLength: summaryLengthEnum = .threeHundred
    
    //let transcript: String
    //    let startDate: Date
    //    let endDate: Date?
    //    let duration: Int16
    
    @Published var meeting: MeetingModel? = MeetingModel.example
    @Published var invalidMeeting: Bool = true
    @Published var currentSpeaker: EmployeeModel? = nil
    
    
    init() {
        topic = "Testing"
        createMeeting(employees: [.example, .example2, .example3, .example4, .example5, .example6])
    }
    
    func createMeeting(employees: [EmployeeModel]) {
        meeting = MeetingModel(attendees: employees, topic: topic, summaryLength: summaryLength)
        currentSpeaker = meeting?.attendees.first
    }
    
    func isSpeaker(_ employee: EmployeeModel) -> Bool {
        return employee.id == currentSpeaker?.id
    }
    
    func reset() {
        withAnimation {
            topic = ""
            meeting = nil
            summaryLength = .threeHundred
        }
    }
 
    func cancleMeeting() {
        withAnimation {
            meeting = nil
        }
    }
    
    func changeSpeaker(_ speaker: EmployeeModel) {
        guard let curr = currentSpeaker else { return }
        if curr.id == speaker.id { return }
        currentSpeaker = speaker
    }
}
