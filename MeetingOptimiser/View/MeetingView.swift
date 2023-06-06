//
//  MeetingView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 6/6/23.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    
    @StateObject var speechRecogniser: SpeechRecognizer = SpeechRecognizer()
    @ObservedObject var meetingVM: MeetingViewModel
    @State private var isRecording = false
    
    var body: some View {
        VStack {
            Text("Speaker is : \(meetingVM.currentSpeaker?.name ?? "")")
            
            Text("Transcript")
            Text(speechRecogniser.transcript)
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
                isRecording = true
                speechRecogniser.resetTranscript()
                speechRecogniser.startTranscribing()
            } label: {
                Text("Start transcribe")
            }
            
            Button {
                isRecording = false
                speechRecogniser.stopTranscribing()
            } label: {
                Text("Stop ")
            }
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(meetingVM: MeetingViewModel())
    }
}
