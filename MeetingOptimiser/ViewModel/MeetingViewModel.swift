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
    
    @Published var meeting: MeetingModel? = nil
    @Published var invalidMeeting: Bool = true
    @Published var currentSpeaker: EmployeeModel? = nil
    @Published var secondsElapsed = 0
    @Published var history: [MeetingModel] = []
    
    private weak var timer: Timer?
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var startDate: Date?
    
    /// Start the timer.
    func startMeeting() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.update()
        }
        timer?.tolerance = 0.1
        currentSpeaker = meeting?.attendees.first ?? .example
    }
    
    func endMeeting(transcripts: [TranscriptModel]) {
        timer?.invalidate()
        meeting = meeting?.updateMeeting(transcripts, startDate: startDate ?? Date())
        history.append(meeting ?? .example)
        withAnimation {
            meeting = nil
        }
    }
    
    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate else { return }
            let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            self.secondsElapsed = secondsElapsed
        }
    }
    
    init() {
//        topic = "Testing"
//        createMeeting(employees: [.example, .example2, .example3, .example4, .example5, .example6])
    }
    
    func createMeeting(employees: [EmployeeModel]) {
        withAnimation {
            meeting = MeetingModel(attendees: employees, topic: topic, summaryLength: summaryLength)
            currentSpeaker = meeting?.attendees.first
        }
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
