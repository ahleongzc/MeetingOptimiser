//
//  SelectSingleEmployee.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 1/6/23.
//

import SwiftUI

struct SelectSingleEmployeeView: View {
    
    @EnvironmentObject var empVM: EmployeesViewModel
    
    let employeeSelection: SelectionEmployeeModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(employeeSelection.employee.name)
                    .font(.title2)
                    .bold()
                VStack(alignment: .leading) {
                    Text(employeeSelection.employee.id)
                    Text(employeeSelection.employee.position.rawValue)
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            
            Spacer()
            
            if let first = empVM.selectedEmployees.first {
                if employeeSelection.employee == first {
                    Text("First speaker")
                        .font(.subheadline)
                }
            }
            
            if employeeSelection.isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
    }
}

struct SelectSingleEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSingleEmployeeView(employeeSelection: .example)
            .environmentObject(EmployeesViewModel())
    }
}
