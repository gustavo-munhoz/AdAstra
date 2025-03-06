//
//  UserPersistenceFacade.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import UIKit

class UserPersistenceFacade {
    let dataService: UserDataService
    let imageService: ImageService
    
    init(dataService: UserDataService, imageService: ImageService) {
        self.dataService = dataService
        self.imageService = imageService
    }
    
    func updateUser(_ userToWrite: User) async throws {
        // MARK: - We currently don't support chaging profile pictures.
//        if userToWrite.profilePicture != .defaultUserImage() {
//            try await imageService.uploadImage(
//                userToWrite.profilePicture,
//                forDocId: userToWrite.id
//            )
//        }
        
        let dtoToWrite = UserDTO.mappedFrom(user: userToWrite)
        
        try await dataService.updateUser(dtoToWrite)
    }
    
    func getUserProfilePicture(docId: String) async -> UIImage {
        await fetchUserImageFromImageService(docId: docId)
    }
    
    func getUserFromConnectionPassword(_ password: String) async throws -> User {
        let sanitizedInput = password.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        let dto = try await dataService.fetchUser(withConnectionPassword: sanitizedInput)
        
        guard let docId = dto.docId else {
            throw FirestoreError.missingDocumentId
        }
        
        let pictureURL = await fetchUserProfilePictureURL(docId: docId)
        
        return try dto.mappedToUser(profilePictureURL: pictureURL)
    }
    
    func getAllUsers(sortedBy sortingFunction: ((User, User) throws -> Bool)? = nil) async -> [User] {
        let fetchedUsers = await fetchUsersFromDataService()
        
        return await withTaskGroup(of: User?.self) { group in
            for userDTO in fetchedUsers {
                group.addTask { [weak self] in
                    guard let self, let docId = userDTO.docId else { return nil }
                    
                    let profilePictureURL = await self.fetchUserProfilePictureURL(docId: docId)
                    
                    return try! userDTO.mappedToUser(profilePictureURL: profilePictureURL)
                }
            }
            
            var users: [User] = []
            for await user in group {
                if let user { users.append(user) }
            }
            
            guard let sortingFunction else { return users }
            
            do {
                return try users.sorted(by: sortingFunction)
            } catch {
                print(error.localizedDescription)
                return users
            }
        }
    }
    
    private func fetchUsersFromDataService() async -> [UserDTO] {
        do {
            return try await dataService.fetchAllUsers()
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    private func fetchUserProfilePictureURL(docId: String) async -> URL? {
        do {
            return try await imageService.getStorageURL(for: docId)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func fetchUserImageFromImageService(docId: String) async -> UIImage {
        do {
            return try await imageService.fetchImage(forDocId: docId)
        } catch {
            print(error.localizedDescription)
            return .defaultUserImage()
        }
    }
}

extension UserPersistenceFacade {
    static func firebase() -> UserPersistenceFacade {
        UserPersistenceFacade(
            dataService: FirestoreUserDataService(),
            imageService: StorageImageService()
        )
    }
}
