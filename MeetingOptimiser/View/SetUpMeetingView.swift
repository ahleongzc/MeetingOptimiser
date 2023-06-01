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
            VStack {
                HStack {
                    DigitalClockView()
                        .padding()
                    Spacer()
                }
                
                Form {
                    Section {
                        TextField("Enter topic here", text: $meetingVm.topic)
                            .padding()
                    } header: {
                        Text("Meeting Topic")
                    }
                    
                    
                    Section {
                        ForEach(empVM.selectedEmployees) { selectedEmp in
                            Text(selectedEmp.name ?? "")
                        }
                    } header: {
                        Text("Attendees")
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        addAttendees.toggle()
                    } label: {
                        Text("Add attendees")
                    }
                    .foregroundColor(.blue)
                    .padding()
                    
                    
                    
                    Spacer()
                    
                    
                    NavigationLink {
                        MeetingView(meeting: meetingVm.meeting)
                    } label: {
                        Text("Start Meeting")
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .sheet(isPresented: $addAttendees) {
                SelectEmployeesView()
            }
            .navigationTitle("Meeting Optimiser")
        }
    }
}

struct SetUpMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        SetUpMeetingView()
            .environmentObject(EmployeesViewModel())
    }
}
