//
//  MeetingsViewModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation
import SwiftUI

class MeetingViewModel: ObservableObject {
    
    // let attendees: [Employee]
    @Published var topic: String = ""
    //    let summary: String
    @Published var summaryLength: summaryLengthEnum = .threeHundred
    
    //let transcript: String
    //    let startDate: Date
    //    let endDate: Date?
    //    let duration: Int16
    
    @Published var meeting: MeetingModel? = nil
    @Published var invalidMeeting: Bool = true
    
    init() {
        
    }
    
    func createMeeting(attendees: [Employee]) {
        withAnimation {
            meeting = MeetingModel(attendees: attendees, topic: topic, summaryLength: summaryLength)
        }        
    }
    
    func reset() {
        withAnimation {
            topic = ""
            meeting = nil
        }
    }
}
