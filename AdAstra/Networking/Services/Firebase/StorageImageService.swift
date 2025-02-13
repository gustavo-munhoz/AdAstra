//
//  StorageImageService.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import UIKit
import FirebaseStorage

enum StorageError: Error {
    case invalidImageData
    case imageNotFound
}

class StorageImageService: ImageService {
    
    let storage = Storage.storage()
    
    func uploadImage(_ image: UIImage, forUserID uid: String) async throws -> URL {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw StorageError.invalidImageData
        }
        
        let storageRef = getStorageReference(for: uid)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = try await storageRef.putDataAsync(
            imageData,
            metadata: metadata
        )
        
        return try await storageRef.downloadURL()
    }
    
    func fetchImage(forUserID uid: String) async throws -> UIImage {
        let storageRef = getStorageReference(for: uid)
        
        let maxDownloadSize: Int64 = 1024 * 1024 * 5
        let data = try await storageRef.data(maxSize: maxDownloadSize)
        
        guard let image = UIImage(data: data) else {
            throw StorageError.imageNotFound
        }
        
        return image
    }
    
    private func getStorageReference(for uid: String) -> StorageReference {
        storage
            .reference()
            .child("profile_pictures")
            .child(uid)
            .child("profile.jpg")
    }
}
