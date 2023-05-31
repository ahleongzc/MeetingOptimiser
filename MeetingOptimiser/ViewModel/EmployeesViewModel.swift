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
    @Published var errorMessage: String?

    init() {
        getEmployees()
    }
    
    func getEmployees() {
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
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
