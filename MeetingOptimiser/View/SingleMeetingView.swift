//
//  SingleMeetingView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 12/6/23.
//

import SwiftUI

struct SingleMeetingView: View {
    
    let meeting: MeetingModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(meeting.startDate?.formatted(date: .numeric, time: .shortened) ?? "")
            Text(meeting.topic)
            Text("Attendee count: \(meeting.attendees.count)")
        }
    }
}

struct SingleMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        SingleMeetingView(meeting: MeetingModel.example)
    }
}
