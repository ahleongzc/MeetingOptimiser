//
//  MeetingView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 6/6/23.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    
    @StateObject var speechRecVM = SpeechRecognizerViewModel()
    @StateObject var transcriptMGR = TranscriptManager()
    @EnvironmentObject var empVM: EmployeesViewModel
    
    @ObservedObject var meetingVM: MeetingViewModel
    @State var endMeetingConfirmation: Bool = false
    @State var currSpeakerDate: Date = Date()
    
    var body: some View {
        VStack {
            
            Text("Second elapsed: \(meetingVM.secondsElapsed)")
            
            List {
                Section {
                    ForEach(meetingVM.meeting?.attendees ?? []) { attendee in
                        HStack {
                            SpeakerView(speaker: attendee)
                                .contentShape(Rectangle())
                                .font(isMainSpeaker(attendee) ? .body.bold() : .none)
                                .onTapGesture {
                                    changeSpeaker(attendee)
                                }
                            
                            Spacer()
                            
                            if isMainSpeaker(attendee) {
                                Text("is speaking")
                                    .bold()
                            }
                        }
                    }
                }
            }
            
            HStack {
                Text("Current speaker: ")
                Text(meetingVM.currentSpeaker?.name ?? "")
            }
            
            Text(speechRecVM.transcript)
            
            Spacer()
            
            Button {
                endMeetingConfirmation.toggle()
            } label: {
                Text("End meeting")
            }
        }
        .onAppear {
            startMeeting()
        }
        .toolbar(.hidden)
        .alert("End Meeting", isPresented: $endMeetingConfirmation) {
            Button("Cancle", role: .cancel) {}
            Button("Confirm", role: .destructive) { endMeeting() }
        }
    }
    
    func startMeeting() {
        speechRecVM.resetTranscript()
        speechRecVM.startTranscribing()
        meetingVM.startMeeting()
    }
    
    func endMeeting() {
        speechRecVM.returnTranscript { transcript in
            saveTranscript(transcript)
        }
        speechRecVM.stopTranscribing()
        meetingVM.endMeeting(transcripts: transcriptMGR.transcripts)
        meetingVM.reset()
        empVM.reset()
    }
    
    func isMainSpeaker(_ curr: EmployeeModel) -> Bool {
        return curr == meetingVM.currentSpeaker
    }
    
    func changeSpeaker(_ attendee: EmployeeModel) {
        speechRecVM.returnTranscript { transcript in
            saveTranscript(transcript)
        }
        meetingVM.changeSpeaker(attendee)
    }
    
    func saveTranscript(_ transcript: String) {
        let newTranscriptModel = TranscriptModel(transcript: transcript, speaker: meetingVM.currentSpeaker ?? .example, duration: 10, startTime: currSpeakerDate)
        currSpeakerDate = Date()
        transcriptMGR.addTranscript(newTranscriptModel)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(meetingVM: MeetingViewModel())
            .environmentObject(EmployeesViewModel())
    }
}
