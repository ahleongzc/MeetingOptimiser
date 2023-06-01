//
//  SelectSingleEmployee.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 1/6/23.
//

import SwiftUI

struct SelectSingleEmployeeView: View {
    
    let employee: SelectionEmployeeModel
    
    var body: some View {
        HStack {
            Text(employee.employee.name)
            Spacer()
            if employee.isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
    }
}

struct SelectSingleEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSingleEmployeeView(employee: .example)
    }
}
