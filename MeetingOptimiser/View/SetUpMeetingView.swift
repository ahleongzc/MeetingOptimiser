//
//  SetUpMeetingView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import SwiftUI

struct SetUpMeetingView: View {
    
    @StateObject var meetingVm = MeetingViewModel()
    @EnvironmentObject var empVM: EmployeesViewModel
    @State var addAttendees = false
    
    var body: some View {
        NavigationView {
            VStack() {
                HStack {
                    DigitalClockView()
                        .padding()
                    Spacer()
                }
                
                TextField("Enter topic here", text: $meetingVm.topic)
                    .padding()
        
                
                Button("Add attendees") {
                    addAttendees.toggle()
                }
                Spacer()
                
                ForEach(empVM.selectedEmployees) { selectedEmp in
                    Text(selectedEmp.id ?? "wow")
                }
            }
            .navigationTitle("Meeting Optimiser")
            .sheet(isPresented: $addAttendees) {
                SelectEmployeesView()
            }
            }
    }
}

struct SetUpMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        SetUpMeetingView()
            .environmentObject(EmployeesViewModel())
    }
}
