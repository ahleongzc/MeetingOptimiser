//
//  MeetingView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 1/6/23.
//

import SwiftUI

struct MeetingConfirmationView: View {
    
    @ObservedObject var meetingVM: MeetingViewModel
    @EnvironmentObject var empVM: EmployeesViewModel
    
    let meeting: MeetingModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Meeting topic:")
                            .font(.title3)
                            .bold()
                        Text(meeting.topic)
                            .padding(.top, 1)
                    }
                    Spacer()
                }
                .padding()
                
                
                HStack {
                    Text("Attendees:")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                .padding()
                
                List {
                    ForEach(meeting.attendees) { attendee in
                        HStack {
                            Text(attendee.name)
                        }
                    }
                }
                .listStyle(.plain)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        MeetingView(meetingVM: meetingVM)
                    } label: {
                        Text("Start meeting")
                    }
                    .padding()

                    Spacer()
                    
                    Button(role: .destructive) {
                        meetingVM.cancleMeeting()
                    } label: {
                        Text("Cancle")
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Confirmation page")
        }
    }
}

struct MeetingConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingConfirmationView(meetingVM: MeetingViewModel(), meeting: .example)
            .environmentObject(EmployeesViewModel())
    }
}
