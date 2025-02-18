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
        var pictureURL: URL? = nil
        if userToWrite.profilePicture != .defaultUserImage() {
            pictureURL = try await imageService.uploadImage(
                userToWrite.profilePicture,
                forDocId: userToWrite.id
            )
        }
        
        let dtoToWrite = UserDTO.mappedFrom(user: userToWrite, imageURL: pictureURL)
        
        try await dataService.updateUser(dtoToWrite)
    }
    
    func getUserFromConnectionPassword(_ password: String) async throws -> User {
        let dto = try await dataService.fetchUser(withConnectionPassword: password)
        
        guard let docId = dto.docId else {
            throw FirestoreError.missingDocumentId
        }
        
        let image = await fetchUserImageFromImageService(docId: docId)
        
        return try await makeUser(from: dto, with: image)
    }
    
    func getAllUsers(sortedBy sortingFunction: ((User, User) throws -> Bool)? = nil) async -> [User] {
        let fetchedUsers = await fetchUsersFromDataService()
        
        return await withTaskGroup(of: User?.self) { group in
            for userDTO in fetchedUsers {
                group.addTask { [weak self] in
                    guard let self, let docId = userDTO.docId else { return nil }
                    
                    let profileImage = await self.fetchUserImageFromImageService(docId: docId)
                    
                    return try! await makeUser(from: userDTO, with: profileImage)
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
    
    private func makeUser(from dto: UserDTO, with image: UIImage) async throws -> User {
        guard let id = dto.docId else {
            throw FirestoreError.missingDocumentId
        }
        
        return User(
            id: id,
            name: dto.name,
            course: dto.course,
            institution: dto.institution,
            shift: dto.shift,
            interests: dto.interests,
            pronouns: dto.pronouns,
            connectionPassword: dto.connectionPassword,
            connectionCount: dto.connectionCount,
            connectedUsers: dto.connectedUsers,
            secretFact: dto.secretFact,
            profilePicture: image,
            planet: Planet(name: dto.planet.name)
        )
    }
    
    private func fetchUsersFromDataService() async -> [UserDTO] {
        do {
            return try await dataService.fetchAllUsers()
        } catch {
            print(error.localizedDescription)
            return []
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
