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
        HStack {
            VStack(alignment: .leading) {
                Text(employee.name)
                    .font(.title2)
                    .bold()
                VStack(alignment: .leading) {
                    Text(employee.id)
                    Text(employee.email)
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(employee.position.rawValue)
                .font(.subheadline)
                .foregroundColor(.blue)
        }
    }
}

struct SingleEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        SingleEmployeeView(employee: EmployeeModel.example)
    }
}
