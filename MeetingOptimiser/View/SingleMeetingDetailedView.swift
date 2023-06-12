//
//  SingleMeetingDetailedView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 12/6/23.
//

import SwiftUI

struct SingleMeetingDetailedView: View {
    
    let meeting: MeetingModel
    
    var body: some View {
        VStack {
            ForEach(meeting.transcripts ?? []) { transcriptModel in
                VStack {
                    Text(transcriptModel.speaker.name)
                    Text(transcriptModel.startTime.description)
                    Text(transcriptModel.transcript)
                }
            }
        }
    }
}

struct SingleMeetingDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        SingleMeetingDetailedView(meeting: .example)
    }
}
