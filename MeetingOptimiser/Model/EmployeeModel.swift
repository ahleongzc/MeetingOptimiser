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
    
    static let example = EmployeeModel(id: "12345", email: "email", name: "name", position: .SE)
    static let example2 = EmployeeModel(id: "11111", email: "email2", name: "name2", position: .CEO)
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
