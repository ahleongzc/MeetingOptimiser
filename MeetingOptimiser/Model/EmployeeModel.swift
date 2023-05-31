//
//  EmployeeModel.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import Foundation

struct EmployeeModel {
    
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
