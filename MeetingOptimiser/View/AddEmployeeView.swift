//
//  AddEmployeeView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import SwiftUI

struct AddEmployeeView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var entryVM = EmployeeEntryViewModel()
    @EnvironmentObject var empVM: EmployeesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Employee ID", text: $entryVM.id)
                .autocorrectionDisabled()
                .padding()
            
            TextField("Name", text: $entryVM.name)
                .autocorrectionDisabled()
                .padding()
            
            TextField("Email", text: $entryVM.email)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding()
            
            HStack {
                Text("Position : ")
                    .padding()
                
                Picker("Position", selection: $entryVM.position) {
                    ForEach(PositionEnum.allCases, id: \.id) { type in
                        Text(type.rawValue)
                    }
                }.pickerStyle(.menu)
            }
            
            HStack {
                
                Spacer()
                
                Button {
                    entryVM.generateEmployeeModel { employee in
                        if let employee = employee {
                            empVM.addEmployee(employee: employee)
                            dismiss()
                        }
                    }
                } label: {
                    Text("Add to database")
                }
                .disabled(entryVM.fieldsEmpty)
                .padding()
                .alert(isPresented: $entryVM.fieldNotValid) {
                    Alert(title: Text("Error with \(entryVM.inputErrorType)"), message: Text("\(entryVM.inputErrorDescription)"))
                }
                
                Spacer()
            }
        
            
            
            Spacer()
        }.navigationTitle("Employee form")
        
    }
}

struct AddEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddEmployeeView()
                .environmentObject(EmployeesViewModel())
        }
    }
}
