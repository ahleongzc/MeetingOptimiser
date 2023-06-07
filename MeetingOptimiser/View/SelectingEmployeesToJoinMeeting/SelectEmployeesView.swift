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
            Text("The first person chosen will be the first speaker (swipe to set)")
                .multilineTextAlignment(.center)
                .font(.callout)
                .foregroundColor(.gray)
                .bold()
                .padding()
            
            List {
                ForEach(empVM.employeeSelectionList) { employeeSelection in
                    SelectSingleEmployeeView(employeeSelection: employeeSelection)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.linear) {
                                empVM.choseEmployee(employee: employeeSelection)
                            }
                        }
                        .swipeActions {
                            Button {
                                empVM.moveToFirst(employeeSelection)
                            } label: {
                                Text("Set as 1st")
                            }
                        }
                }
            }
            Button {
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
