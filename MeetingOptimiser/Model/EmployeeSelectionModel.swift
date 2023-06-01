//
//  EmployeeSelectionModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 1/6/23.
//

import Foundation

struct EmployeeSelectionModel: Identifiable {
    
    let employee: EmployeeModel
    let id: String
    let isSelected: Bool
    
    init(employee: EmployeeModel) {
        self.employee = employee
        self.id = employee.id
        self.isSelected = false
    }
    
}
