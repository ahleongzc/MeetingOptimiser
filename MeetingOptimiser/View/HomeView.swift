//
//  HomeView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var meetingVm = MeetingViewModel()
    
    var body: some View {
        if let meeting = meetingVm.meeting {
            MeetingConfirmationView(meetingVM: meetingVm, meeting: meeting)
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .bottom).animation(.easeIn),
                        removal: .move(edge: .bottom).animation(.easeIn)
                    )
                )
        } else {
            TabView {
                SetUpMeetingView(meetingVm: meetingVm)
                    .tabItem {
                        Label("Meeting", systemImage: "waveform.circle.fill")
                    }
                
                AllEmployeesView()
                    .tabItem {
                        Label("Employees", systemImage: "person.3.fill")
                    }
                
                MeetingHistoryView(meetingVM: meetingVm)
                    .tabItem {
                        Label("History", systemImage: "internaldrive.fill")
                    }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(EmployeesViewModel())
    }
}
