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
    
    func saveUser(_ user: FirebaseUserDTO) async throws {
        try db
            .collection(FirestoreCollection.users.rawValue)
            .document(user.uid)
            .setData(from: user)
    }
    
    func fetchUser(withUserID uid: String) async throws -> FirebaseUserDTO {
        try await db
            .collection(FirestoreCollection.users.rawValue)
            .document(uid)
            .getDocument(as: FirebaseUserDTO.self)
    }
    
    func fetchAllUsers() async throws -> [FirebaseUserDTO] {
        try await db
            .collection(FirestoreCollection.users.rawValue)
            .getDocuments()
            .documents
            .compactMap { document in
                try document.data(as: FirebaseUserDTO.self)
            }
    }
}
