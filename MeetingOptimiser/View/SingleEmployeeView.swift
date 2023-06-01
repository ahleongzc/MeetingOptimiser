//
//  SingleEmployeeView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import SwiftUI

struct SingleEmployeeView: View {
    
    let employee: EmployeeModel
    
    var body: some View {
        VStack {
            Text(employee.name)
            Text(employee.id)
        }
    }
}

struct SingleEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        SingleEmployeeView(employee: EmployeeModel.example)
    }
}
