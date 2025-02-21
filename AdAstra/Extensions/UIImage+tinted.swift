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
    
    func tinted(
        withGradientColors gradientColors: [UIColor]
    ) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.size)
        
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: self.size)
            self.draw(in: rect)
            
            let cgColors = gradientColors.map { $0.cgColor }
            guard let gradient = CGGradient(
                colorsSpace: CGColorSpaceCreateDeviceRGB(),
                colors: cgColors as CFArray,
                locations: nil
            ) else {
                return
            }
            
            let start = CGPoint(x: self.size.width / 2, y: 0)
            let end = CGPoint(x: self.size.width / 2, y: self.size.height)
            
            context.cgContext.setBlendMode(.multiply)
            context.cgContext.drawLinearGradient(
                gradient,
                start: start,
                end: end,
                options: []
            )
        }
    }
}
