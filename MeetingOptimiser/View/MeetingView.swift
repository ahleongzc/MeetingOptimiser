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
    
    var body: some View {
        VStack {
            Text("\(meetingVM.secondsElapsed)")
            Text("Speaker is : \(meetingVM.currentSpeaker?.name ?? "")")
            
            Text("Transcript")
            Text(speechRecVM.transcript)
            List {
                ForEach(meetingVM.meeting?.attendees ?? []) { attendee in
                    SpeakerView(speaker: attendee)
                        .background(meetingVM.isSpeaker(attendee) ? .red : .green)
                        .onTapGesture {
                            meetingVM.changeSpeaker(attendee)
                        }
                }
            }
            
            Button {
                speechRecVM.stopTranscribing()
                meetingVM.stopMeeting()
            } label: {
                Text("Stop ")
            }
        }
        .onAppear {
            speechRecVM.resetTranscript()
            speechRecVM.startTranscribing()
            meetingVM.startMeeting()
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(meetingVM: MeetingViewModel())
    }
}
