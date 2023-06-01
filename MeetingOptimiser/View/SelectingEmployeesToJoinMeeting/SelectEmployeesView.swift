//
//  SelectEmployeesView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 1/6/23.
//

import SwiftUI

struct SelectEmployeesView: View {
    
    @EnvironmentObject var empVM: EmployeesViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            List {
                ForEach(empVM.employeeSelectionList) { employee in
                    SelectSingleEmployeeView(employee: employee)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.linear) {
                                empVM.choseEmployee(employee: employee)
                            }
                        }
                }
            }
            Button {
                empVM.getSelectedEmployees()
                dismiss()
            } label: {
                Text("Finish")
            }
        }
    }
}

struct SelectEmployeesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectEmployeesView()
                .environmentObject(EmployeesViewModel())
        }
    }
}
