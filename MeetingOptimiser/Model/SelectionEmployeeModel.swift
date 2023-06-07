//
//  SelectionEmployeeModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 1/6/23.
//

import Foundation

struct SelectionEmployeeModel: Identifiable {
    
    let id: String
    let employee: EmployeeModel
    let isSelected: Bool
    
    init(employee: EmployeeModel) {
        self.id = employee.id
        self.employee = employee
        self.isSelected = false
    }
    
    init(employee: EmployeeModel, isSelected: Bool) {
        self.id = employee.id
        self.employee = employee
        self.isSelected = isSelected
    }
    
    func updateSelection() -> SelectionEmployeeModel {
        return SelectionEmployeeModel(employee: employee, isSelected: !isSelected)
    }
    
    func select() -> SelectionEmployeeModel {
        return SelectionEmployeeModel(employee: employee, isSelected: true)
    }
    
    static let example = SelectionEmployeeModel(employee: EmployeeModel.example)
    
}
