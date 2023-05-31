//
//  EmployeeEntryViewModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation


class EmployeeEntryViewModel: ObservableObject {
    
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var position: PositionEnum = .E
    
    @Published var employeeCreationConfirmation: Bool = false
    @Published var fieldNotValid: Bool = false
    
    @Published var inputErrorType: String = ""
    @Published var inputErrorDescription: String = ""
    
    var fieldsEmpty: Bool {
        id.isEmpty || name.isEmpty || email.isEmpty
    }
    
    init() {
        
    }
    
    func checkIfValid() {
        if (checkId() && checkName() && checkEmail()) {
            fieldNotValid.toggle()
            return
        }
    }
    
    private func checkName() -> Bool {
        let nameRegex = "[A-Za-z ]+"
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        let nameIsValid = namePred.evaluate(with: self.name)
        
        if (!nameIsValid) {
            inputErrorType = "Name field"
            inputErrorDescription = "Name can only contain alphabets"
        }
        
        return nameIsValid
    }
    
    private func checkId() -> Bool {
        let idRegex = "[0-9]{5}"
        let idPred = NSPredicate(format:"SELF MATCHES %@", idRegex)
        let idIsValid = idPred.evaluate(with: self.id)
        
        if (!idIsValid) {
            inputErrorType = "Employee Id field"
            inputErrorDescription = "Employee Id must be exactly 5 characters"
        }
        
        return idIsValid
    }
    
    private func checkEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        let emailIsValid = emailPred.evaluate(with: self.email)
        
        if (!emailIsValid) {
            inputErrorType = "Email field"
            inputErrorDescription = "Please enter a valid email"
        }
        
        return emailIsValid
    }
    
    func generateEmployeeModel(completionHandler: @escaping (_ employee: EmployeeModel) -> ()) {
        let newEmp = EmployeeModel(id: id, email: email, name: name, position: position)
        completionHandler(newEmp)
    }
    
    
    func resetFields() {
        self.id = ""
        self.name = ""
        self.email = ""
        self.position = .E
    }
    
}
