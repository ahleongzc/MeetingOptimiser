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
    @ObservedObject var meetingVM: MeetingViewModel
    @State var endMeetingConfirmation: Bool = false
    @State var transcripts = [String]()
    
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
                    ForEach(transcripts, id: \.self) { transcript in
                        Text(transcript)
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
        speechRecVM.saveTranscript { transcript in
            transcripts.append(transcript)
        }
        speechRecVM.stopTranscribing()
        meetingVM.endMeeting()
    }
    
    func isMainSpeaker(_ curr: EmployeeModel) -> Bool {
        return curr == meetingVM.currentSpeaker
    }
    
    func changeSpeaker(_ attendee: EmployeeModel) {
        meetingVM.changeSpeaker(attendee)
        speechRecVM.saveTranscript { transcript in
            transcripts.append(transcript)
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(meetingVM: MeetingViewModel())
    }
}
