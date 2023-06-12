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
    
    @ObservedObject var meetingVM: MeetingViewModel
    @State var endMeetingConfirmation: Bool = false
    @State var currSpeakerDate: Date = Date()
    
    var body: some View {
        VStack {
            
            Text("Second elapsed: \(meetingVM.secondsElapsed)")
            Text("Transcript: \(speechRecVM.transcript)")
            
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
                
                Section {
                    ForEach(transcriptMGR.transcripts) { transcriptModel in
                        Text(transcriptModel.transcript)
                    }
                }
            }
            
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
        transcriptMGR.addTranscript(newTranscriptModel)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(meetingVM: MeetingViewModel())
    }
}
