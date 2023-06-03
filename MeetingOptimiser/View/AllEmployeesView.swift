//
//  AllEmployeesView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import SwiftUI

struct AllEmployeesView: View {
    
    @EnvironmentObject var empVM: EmployeesViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(empVM.employees) { unformattedEmp in
                            let employee = EmployeeModel(employee: unformattedEmp)
                            SingleEmployeeView(employee: employee)
                        }.onDelete(perform: empVM.deleteEmployee)
                    }
                    
                    NavigationLink {
                        AddEmployeeView()
                    } label: {
                        Text("Add employee")
                            .padding()
                    }
                    
                }
                .navigationTitle("All Employees")
                .alert(isPresented: $empVM.duplicateEntry) {
                    Alert(title: Text("Duplicate entry"), message: Text(empVM.errorMessage))
                }
            }
        }
    }
}

struct AllEmployeesView_Previews: PreviewProvider {
    static var previews: some View {
        AllEmployeesView()
            .environmentObject(EmployeesViewModel())
    }
}
