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

enum FirestoreError: Error, LocalizedError {
    case userNotFound
    
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "User not found... try another code!"
        }
    }
}

class FirestoreUserDataService: UserDataService {
    
    private let db = Firestore.firestore()
    
    func saveUser(_ user: UserDTO) async throws {
        try db
            .collection(FirestoreCollection.users.rawValue)
            .document()
            .setData(from: user)
    }
    
    func fetchUser(withConnectionPassword password: String) async throws -> UserDTO {
        let querySnapshot = try await db
            .collection(FirestoreCollection.users.rawValue)
            .whereField("connectionPassword", isEqualTo: password)
            .limit(to: 1)
            .getDocuments()
        
        guard let document = querySnapshot.documents.first else {
            throw FirestoreError.userNotFound
        }
        
        var userDTO = try document.data(as: UserDTO.self)
        userDTO.docId = document.documentID
        
        return userDTO
    }
    
    func fetchAllUsers() async throws -> [UserDTO] {
        try await db
            .collection(FirestoreCollection.users.rawValue)
            .getDocuments()
            .documents
            .compactMap { document in
                var userDTO = try document.data(as: UserDTO.self)
                userDTO.docId = document.documentID
                
                return userDTO
            }
    }
}
