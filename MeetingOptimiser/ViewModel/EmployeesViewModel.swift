//
//  EmployeesViewModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation
import CoreData

class EmployeesViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var employees: [Employee] = []
    @Published var employeeSelectionList: [SelectionEmployeeModel] = []
    @Published var selectedEmployees: [EmployeeModel] = []
    @Published var duplicateEntry: Bool = false
    @Published var errorMessage: String = ""
    @Published var addAttendees: Bool = false

    init() {
        getEmployees()
    }
    
    func reset() {
        selectedEmployees = []
        reinitialiseEmployeeSelectionList()
    }
    
    func getSelectedEmployees() {
        selectedEmployees = []
        for selectionEmployeeModel in employeeSelectionList {
            if selectionEmployeeModel.isSelected {
                let empModel = selectionEmployeeModel.employee
                selectedEmployees.append(empModel)
            }
        }
    }
    
    func reinitialiseEmployeeSelectionList() {
        employeeSelectionList = []
        for employee in employees {
            let empModel = EmployeeModel(employee: employee)
            let selEmpModel = SelectionEmployeeModel(employee: empModel)
            employeeSelectionList.append(selEmpModel)
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        do {
            employees = try manager.context.fetch(request)
            reinitialiseEmployeeSelectionList()
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func choseEmployee(employee: SelectionEmployeeModel) {
        if let index = employeeSelectionList.firstIndex(where: { $0.id == employee.id }) {
            employeeSelectionList[index] = employee.updateSelection()
            print("")
        }
    }
    
    func addEmployee(employee: EmployeeModel) {
        let newEmployee = Employee(context: manager.context)
        newEmployee.id = employee.id
        newEmployee.name = employee.name
        newEmployee.email = employee.email
        newEmployee.position = employee.position.rawValue
        
        if employees.contains(where: { $0.id == employee.id }) {
            errorMessage = "Duplicate ID: \(employee.id)"
            manager.context.delete(newEmployee)
            duplicateEntry.toggle()
            return
        }
        
        saveData()
    }
    
    
    func deleteEmployee(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = employees[index]
        manager.context.delete(entity)
        saveData()
    }
    
    func saveData() {
        manager.save()
        getEmployees()
    }
    
}
