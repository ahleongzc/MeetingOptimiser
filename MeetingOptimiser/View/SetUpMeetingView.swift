//
//  SetUpMeetingView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import SwiftUI

struct SetUpMeetingView: View {
    
    @ObservedObject var meetingVm: MeetingViewModel
    @EnvironmentObject var empVM: EmployeesViewModel
    
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
                        Text("Meeting topic")
                    }
                    
                    Section {
                        Picker("Position", selection: $meetingVm.summaryLength) {
                            ForEach(summaryLengthEnum.allCases, id: \.id) { length in
                                Text("\(length.rawValue)")
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                    } header: {
                        Text("Summary length (words)")
                    }
                    
                    Section {
                        if empVM.selectedEmployees.isEmpty {
                            Text("There must be at least one attendee")
                                .foregroundColor(.secondary.opacity(0.5))
                                .padding()
                        } else {
                            ForEach(empVM.selectedEmployees) { selectedEmp in
                                Text(selectedEmp.name ?? "")
                            }
                        }
                    } header: {
                        Text("Attendees")
                    }
                    
                }
                
                bottomButtons
            }
            .sheet(isPresented: $empVM.addAttendees) {
                SelectEmployeesView()
            }
            .navigationTitle("Meeting Optimiser")
        }
    }
}

extension SetUpMeetingView {
    
    var bottomButtons: some View {
        HStack {
            Spacer()
            
            Button {
                empVM.addAttendees.toggle()
            } label: {
                Text("Add attendees")
            }
            .foregroundColor(.blue)
            .padding()
            
            Spacer()
            
            
            Button {
                meetingVm.createMeeting(attendees: empVM.selectedEmployees)
            } label: {
                Text("Create Meeting")
            }
            .disabled(meetingVm.topic.isEmpty || empVM.selectedEmployees.isEmpty)
            .padding()

            
            Spacer()
        }
    }
}

struct SetUpMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        SetUpMeetingView(meetingVm: MeetingViewModel())
            .environmentObject(EmployeesViewModel())
    }
}
