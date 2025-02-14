//
//  UserDataService.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import Foundation

protocol UserDataService {
    func saveUser(_ user: UserDTO) async throws
    func fetchUser(withUserID uid: String) async throws -> UserDTO
    func fetchAllUsers() async throws -> [UserDTO]
}
