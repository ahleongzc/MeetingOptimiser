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
    @State var date = Date()
    
    let clockTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    let meeting: MeetingModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                Text(meeting.topic)
                
                ForEach(meeting.attendees) { attendees in
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        MeetingView()
                    } label: {
                        Text("Start meeting")
                    }
                    .padding()

                    Spacer()
                    
                    Button(role: .destructive) {
                        empVM.reset()
                        meetingVM.reset()
                    } label: {
                        Text("Cancle")
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct MeetingConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingConfirmationView(meetingVM: MeetingViewModel(), meeting: .example)
            .environmentObject(EmployeesViewModel())
    }
}
