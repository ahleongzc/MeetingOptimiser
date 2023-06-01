//
//  MeetingsViewModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation

class MeetingViewModel: ObservableObject {
    
    // let attendees: [Employee]
    @Published var topic: String = ""
//    let summary: String
    @Published var summaryLength: summaryLengthEnum = .threeHundred
    
    //let transcript: String
//    let startDate: Date
//    let endDate: Date?
//    let duration: Int16
    
    @Published var meeting: MeetingModel = MeetingModel.example
    
    init() {
        
    }
    
    
}
