//
//  SetUpMeetingView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import SwiftUI

struct SetUpMeetingView: View {
    
    let clockTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let calendar = Calendar.current
    
    @State var currentDate = Date()
    @State var hour : NSInteger = 0
    @State var minute : NSInteger = 0
    @State var second : NSInteger = 0
    
    @ObservedObject var meetingVm: MeetingViewModel
    @EnvironmentObject var empVM: EmployeesViewModel
    @State var resetFieldsToggle: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    digitalClock
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
                                if let index = empVM.selectedEmployees.firstIndex(where: { $0.id == selectedEmp.id }) {
                                    if index == 0 {
                                        HStack {
                                            Text(selectedEmp.name)
                                                .bold()
                                            Spacer()
                                            Text("First speaker")
                                        }
                                    } else {
                                        Text(selectedEmp.name)
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Attendees")
                    }
                }
                
                bottomButtons
            }
            .toolbar {
                Button {
                    resetFieldsToggle.toggle()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
            }
            .sheet(isPresented: $empVM.addAttendees) {
                SelectEmployeesView()
            }
            .alert(isPresented: $resetFieldsToggle) {
                Alert(title: Text("Reset Input Fields"), message: Text("This will reset all inputs in the form"), primaryButton: .cancel(), secondaryButton: alertButtonToDelete )
            }
            .navigationTitle("Meeting Optimiser")
        }
    }
}



extension SetUpMeetingView {
    
    var digitalClock: some View {
        ZStack {
            HStack {
                Text("\(currentDate, format: .dateTime.year().month().day())  \(hour):\(minute, specifier: "%.2d"):\(second, specifier: "%.2d")")
            }
            .font(.title2)
            .bold()
        }
        .onReceive(clockTimer) {
            time in
            currentDate = time
            hour = calendar.component(.hour, from: currentDate)
            minute = calendar.component(.minute, from: currentDate)
            second = calendar.component(.second, from: currentDate)
        }
    }
    
    
    var alertButtonToDelete: Alert.Button {
        Alert.Button.destructive(Text("Confirm").bold()) {
            empVM.reset()
            meetingVm.reset()
        }
    }
    
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
                meetingVm.createMeeting(employees: empVM.selectedEmployees)
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
