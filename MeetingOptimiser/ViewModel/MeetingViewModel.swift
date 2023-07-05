//
//  MeetingsViewModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class MeetingViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var topic: String = ""
    @Published var meeting: MeetingModel? = nil
    @Published var invalidMeeting: Bool = true
    @Published var currentSpeaker: EmployeeModel? = nil
    @Published var secondsElapsed = 0
    @Published var history: [Meeting] = []
    @Published var meetings: [MeetingModel] = []
    
    var employees: [Employee] = []
    
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
    
    func findEmployee(employee: EmployeeModel) -> Employee? {
        for emp in employees {
            if let id = emp.id {
                if id == employee.id {
                    return emp
                }
            }
        }
        
        return nil
    }
    
    func addMeeting(meeting: MeetingModel) {
        let newMeeting = Meeting(context: manager.context)
        
        var tempTranscripts = [Transcript]()
        
        for transcript in meeting.transcripts ?? [] {
            let newTranscript = Transcript(context: manager.context)
            newTranscript.id = transcript.id
            newTranscript.employee = findEmployee(employee: transcript.speaker)
            newTranscript.duration = Int16(transcript.duration)
            newTranscript.startTime = transcript.startTime
            newTranscript.transcript = transcript.transcript
            tempTranscripts.append(newTranscript)
        }
        
        
        newMeeting.transcript = NSSet(array: tempTranscripts)
        
        var tempEmployees = [Employee]()
        
        for attendee in meeting.attendees {
            if let emp = findEmployee(employee: attendee) {
                tempEmployees.append(emp)
            }
        }
        
        newMeeting.employee = NSSet(array: tempEmployees)
        newMeeting.id = meeting.id
        newMeeting.topic = meeting.topic
        newMeeting.summary = meeting.summary
        newMeeting.startDate = meeting.startDate
        newMeeting.endDate = meeting.endDate
        newMeeting.duration = Int16(meeting.duration)
        
        saveData()
    }
    
    func saveData() {
        manager.save()
        getMeetings()
    }
    
    func endMeeting(transcripts: [TranscriptModel]) {
        timer?.invalidate()
        meeting = meeting?.updateMeeting(transcripts, startDate: startDate ?? Date())
        addMeeting(meeting: meeting ?? MeetingModel.example)
        
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
        getEmployees()
        getMeetings()
//        topic = "Testing"
//        createMeeting(employees: [.example, .example2, .example3, .example4, .example5, .example6])
    }
    
    func createMeeting(employees: [EmployeeModel]) {
        withAnimation {
            meeting = MeetingModel(attendees: employees, topic: topic)
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

    func getMeetings() {
        let request = NSFetchRequest<Meeting>(entityName: "Meeting")
        let sort = NSSortDescriptor(key: "startDate", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            history = try manager.context.fetch(request)
            meetings = []
            for meeting in history {
                meetings.append(MeetingModel(meeting: meeting))
            }
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    

}
