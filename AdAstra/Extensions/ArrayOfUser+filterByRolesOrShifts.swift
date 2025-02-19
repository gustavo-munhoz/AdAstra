//
//  ArrayOfUser+filterByRolesOrShifts.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 19/02/25.
//

import Foundation

extension Array where Element == User {
    func filterByShifts(_ shifts: Shift...) -> Self {
        filter { shifts.contains($0.shift) }
    }
    
    func filterByRoles(_ roles: Role...) -> Self {
        filter { roles.contains($0.role) }
    }
}
