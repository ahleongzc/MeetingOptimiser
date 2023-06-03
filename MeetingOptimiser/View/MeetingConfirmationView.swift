//
//  MeetingView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 1/6/23.
//

import SwiftUI

struct MeetingConfirmationView: View {
    
    @ObservedObject var meetingVM: MeetingViewModel
    let meeting: MeetingModel
    
    var body: some View {
        VStack {
            Text(meeting.id)
            Text(meeting.topic)
            
            List {
                ForEach(meeting.attendees) { attendees in
                    Text(attendees.id ?? "12345")
                    
                }
            }
            
            NavigationLink {
                MeetingView()
            } label: {
                Text("Start meeting")
            }
        }
        .padding()
    }
}

struct MeetingConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingConfirmationView(meetingVM: MeetingViewModel(), meeting: .example)
    }
}
