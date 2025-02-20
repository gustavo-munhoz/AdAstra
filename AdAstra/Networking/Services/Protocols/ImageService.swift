//
//  ImageService.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import UIKit

protocol ImageService {
    @discardableResult func uploadImage(_ image: UIImage, forDocId docId: String) async throws -> URL
    func fetchImage(forDocId docId: String) async throws -> UIImage
}
