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
    
    var body: some View {
        VStack {
            Text("\(meetingVM.secondsElapsed)")
            Text("Current speaker is : \(meetingVM.currentSpeaker?.name ?? "")")
            
            Text("Transcript")
            Text(speechRecVM.transcript)
            
            List {
                ForEach(meetingVM.meeting?.attendees ?? []) { attendee in
                    HStack {
                        SpeakerView(speaker: attendee)
                            .contentShape(Rectangle())
                            .font(isMainSpeaker(attendee) ? .body.bold() : .none)
                            .onTapGesture {
                                meetingVM.changeSpeaker(attendee)
                            }
                        
                        Spacer()
                        
                        if isMainSpeaker(attendee) {
                            Text("is speaking")
                                .bold()
                        }
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
//            speechRecVM.resetTranscript()
//            speechRecVM.startTranscribing()
//            meetingVM.startMeeting()
        }
        .toolbar(.hidden)
        .alert("End Meeting", isPresented: $endMeetingConfirmation) {
            Button("Cancle", role: .cancel) {}
            Button("Confirm", role: .destructive) { endMeeting() }
        }
    }
    
    func endMeeting() {
        speechRecVM.stopTranscribing()
        meetingVM.endMeeting()
    }
    
    func isMainSpeaker(_ curr: EmployeeModel) -> Bool {
        return curr == meetingVM.currentSpeaker
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(meetingVM: MeetingViewModel())
    }
}
