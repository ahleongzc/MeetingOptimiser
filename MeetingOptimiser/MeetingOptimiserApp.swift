//
//  MeetingOptimiserApp.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import SwiftUI

@main
struct MeetingOptimiserApp: App {
    
    @StateObject var empVM = EmployeesViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
//            MeetingView(meetingVM: MeetingViewModel())
                .environmentObject(empVM)
        }
    }
}
