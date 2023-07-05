//
//  SingleMeetingDetailedView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 12/6/23.
//

import SwiftUI

struct SingleMeetingDetailedView: View {
    
    var meeting: MeetingModel
    
    var body: some View {
        VStack {
            
            Text("\(meeting.topic)")
                .font(.title)
                .bold()
            
            if let summary = meeting.summary {
                VStack (alignment: .leading) {
                    Text("\(summary)")
                }
                .padding()
            }
            
            Section {
                ScrollView {
                    ForEach(meeting.transcripts ?? []) { transcriptModel in
                        SingleTranscriptView(transcript: transcriptModel)
                    }
                }
            } header: {
                HStack {
                    Text("Transcript")
                    Spacer()
                }
            }
            .padding()
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Generate summary")
            }
            .disabled(summaryPresent())
            
        }
        .padding()
    }
    
    func summaryPresent() -> Bool {
        if let _ = meeting.summary {
            return true
        }
        return false
    }
    
    func generateSummary() {
        let summary = "summary"
        meeting.updateSummary(summary: summary)
    }
}

struct SingleMeetingDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SingleMeetingDetailedView(meeting: .example2)
        }
    }
}
