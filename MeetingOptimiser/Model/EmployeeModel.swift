//
//  EmployeeModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation

struct EmployeeModel: Identifiable, Hashable {
    
    let id: String
    let email: String
    let name: String
    let position: PositionEnum
    
    init(id: String, email: String, name: String, position: PositionEnum) {
        self.id = id
        self.email = email
        self.name = name
        self.position = position
    }
    
    init(employee: Employee) {
        self.id = employee.id ?? "Id"
        self.email = employee.email ?? "Email"
        self.name = employee.name ?? "Name"
        self.position = PositionEnum(rawValue: employee.position ?? "Employee") ?? .E
    }
    
    static let example = EmployeeModel(id: "11111", email: "email1", name: "one", position: .CEO)
    static let example2 = EmployeeModel(id: "22222", email: "email2", name: "two", position: .SE)
    static let example3 = EmployeeModel(id: "33333", email: "email3", name: "three", position: .E)
    static let example4 = EmployeeModel(id: "44444", email: "email4", name: "four", position: .SE)
    static let example5 = EmployeeModel(id: "55555", email: "email5", name: "five", position: .SE)
    static let example6 = EmployeeModel(id: "66666", email: "email6", name: "six", position: .SE)
}

enum PositionEnum: String, CaseIterable, Identifiable, Codable {
    
    var id: Self { self }
    
    case CEO = "Chief Executive Officer"
    case CTO = "Chief Technology Officer"
    case CFO = "Chief Financial Officer"
    case COO = "Chief Operating Officer"
    case P = "President"
    case EP = "Executive President"
    case SVP = "Senior Vice President"
    case VP = "Vice President"
    case M = "Manager"
    case E = "Employee"
    case SE = "Software Engineer"
}
