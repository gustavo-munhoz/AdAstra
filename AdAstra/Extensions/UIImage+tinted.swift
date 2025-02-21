//
//  UIImage+tinted.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 21/02/25.
//

import UIKit

extension UIImage {
    func tinted(with color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.size)
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: self.size)
            
            self.draw(in: rect)
            
            context.cgContext.setBlendMode(.multiply)
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.fill(rect)
        }
    }
}
