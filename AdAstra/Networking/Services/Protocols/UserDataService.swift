//
//  UserDataService.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import Foundation

protocol UserDataService {
    func saveUser(_ user: UserDTO) async throws
    func fetchAllUsers() async throws -> [UserDTO]
    func fetchUser(withConnectionPassword password: String) async throws -> UserDTO
}
