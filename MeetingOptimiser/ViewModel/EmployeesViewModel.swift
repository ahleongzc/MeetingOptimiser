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
    @Published var exampleEmployeesInModel = [EmployeeModel.example, EmployeeModel.example2]
    @Published var employeeSelectionList: [SelectionEmployeeModel] = []
    @Published var selectedEmployees: [Employee] = []
    @Published var errorMessage: String?

    init() {
        getEmployees()
    }
    
    func resetSelectedEmployees() {
        
    }
    
    func getSelectedEmployees() {
        selectedEmployees = []
        for selectionEmployeeModel in employeeSelectionList {
            if selectionEmployeeModel.isSelected {
                let model = selectionEmployeeModel.employee
                
                let newEmployee = Employee(context: manager.context)
                newEmployee.id = model.id
                newEmployee.name = model.name
                newEmployee.email = model.email
                newEmployee.position = model.position.rawValue
                
                selectedEmployees.append(newEmployee)
            }
        }
    }
    
    func reinitialiseSelectedEmployees() {
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
            reinitialiseSelectedEmployees()
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
            errorMessage = "Duplicate ID for \(employee.id)"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.errorMessage = nil
            }
            
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
