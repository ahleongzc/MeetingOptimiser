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
            Text(meeting.topic)
                .font(.title3)
                .bold()
            
            HStack {
                Text("Held: ")
                Text(meeting.startDate?.formatted(date: .numeric, time: .omitted) ?? "31/12/2022")
                Text(meeting.startDate?.formatted(date: .omitted, time: .shortened) ?? "12:00 PM")
            }
            Text("Attendee count: \(meeting.attendees.count)")
        }
    }
}

struct SingleMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        SingleMeetingView(meeting: MeetingModel.example)
    }
}
