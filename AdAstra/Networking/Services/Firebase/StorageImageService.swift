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
    
    func uploadImage(_ image: UIImage, forDocId docId: String) async throws -> URL {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw StorageError.invalidImageData
        }
        
        let storageRef = getStorageReference(for: docId)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        _ = try await storageRef.putDataAsync(
            imageData,
            metadata: metadata
        )
        
        return try await storageRef.downloadURL()
    }
    
    func fetchImage(forDocId docId: String) async throws -> UIImage {
        let storageRef = getStorageReference(for: docId)
        
        let maxDownloadSize: Int64 = 1024 * 1024 * 10
        let data = try await storageRef.data(maxSize: maxDownloadSize)
        
        guard let image = UIImage(data: data) else {
            throw StorageError.imageNotFound
        }
        
        return image
    }
    
    private func getStorageReference(for docId: String) -> StorageReference {
        storage
            .reference()
            .child("profile_pictures")
            .child(docId)
            .child("profile.png")
    }
}
