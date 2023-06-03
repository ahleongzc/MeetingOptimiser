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
        TabView {
            SetUpMeetingView()
                .tabItem {
                    Label("One", systemImage: "pencil")
                }
            
            AllEmployeesView()
                .tabItem {
                    Label("Employees", systemImage: "pencil")
                }
            
            MeetingHistoryView()
                .tabItem {
                    Label("History", systemImage: "pencil")
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
