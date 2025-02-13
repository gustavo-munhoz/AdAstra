//
//  ImageService.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import UIKit

protocol ImageService {
    func uploadImage(_ image: UIImage, forUserID uid: String) async throws -> URL
    func fetchImage(forUserID uid: String) async throws -> UIImage
}
