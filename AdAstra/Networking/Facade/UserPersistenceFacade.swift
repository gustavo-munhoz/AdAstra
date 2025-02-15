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
    
    func getUserFromConnectionPassword(_ password: String) async throws -> User {
        let dto = try await dataService.fetchUser(withConnectionPassword: password)
        
        guard let docId = dto.docId else {
            throw FirestoreError.missingDocumentId
        }
        
        let image = await fetchUserImageFromImageService(docId: docId)
        
        return try makeUser(from: dto, with: image)
    }
    
    func getAllUsers() async -> [User] {
        let fetchedUsers = await fetchUsersFromDataService()
        
        return await withTaskGroup(of: User?.self) { group in
            for userDTO in fetchedUsers {
                group.addTask { [weak self] in
                    guard let self, let docId = userDTO.docId else { return nil }
                    
                    let profileImage = await self.fetchUserImageFromImageService(docId: docId)
                    
                    return try! makeUser(from: userDTO, with: profileImage)
                }
            }
            
            var users: [User] = []
            for await user in group {
                if let user { users.append(user) }
            }
            
            return users
        }
    }
    
    private func makeUser(from dto: UserDTO, with image: UIImage) throws -> User {
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
            bio: dto.bio,
            connectionPassword: dto.connectionPassword,
            connectionCount: dto.connectionCount,
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
            return UIImage(systemName: "person.crop.circle") ?? UIImage()
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
