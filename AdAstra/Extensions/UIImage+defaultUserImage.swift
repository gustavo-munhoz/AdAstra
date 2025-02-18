//
//  UIImage+defaultUserImage.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 17/02/25.
//

import UIKit

extension UIImage {
    static func defaultUserImage() -> UIImage {
        UIImage(systemName: "person.crop.circle") ?? UIImage()
    }
}
