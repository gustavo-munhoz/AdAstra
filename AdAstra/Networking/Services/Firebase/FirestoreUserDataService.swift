//
//  FirestoreUserDataService.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import Foundation
import FirebaseFirestore

enum FirestoreCollection: String {
    case users
}

class FirestoreUserDataService: UserDataService {
    
    private let db = Firestore.firestore()
    
    func saveUser(_ user: UserDTO) async throws {
        try db
            .collection(FirestoreCollection.users.rawValue)
            .document(user.uid)
            .setData(from: user)
    }
    
    func fetchUser(withUserID uid: String) async throws -> UserDTO {
        try await db
            .collection(FirestoreCollection.users.rawValue)
            .document(uid)
            .getDocument(as: UserDTO.self)
    }
    
    func fetchAllUsers() async throws -> [UserDTO] {
        try await db
            .collection(FirestoreCollection.users.rawValue)
            .getDocuments()
            .documents
            .compactMap { document in
                try document.data(as: UserDTO.self)
            }
    }
}
