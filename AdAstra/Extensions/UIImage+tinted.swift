//
//  UIImage+tinted.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 21/02/25.
//

import UIKit
import CoreImage.CIFilterBuiltins

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
    
    func tintedWithGradient(gradientColors: [UIColor]) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        let context = CIContext(options: nil)
                
        let filter = CIFilter.linearGradient()
        let startPoint = CGPoint(x: size.width / 2, y: size.height * 0.8)
        let endPoint = CGPoint(x: size.width / 2, y: size.height * 0.4)
        
        filter.point0 = startPoint
        filter.point1 = endPoint
        filter.color0 = CIColor(color: gradientColors.first ?? .white)
        filter.color1 = CIColor(color: gradientColors.last ?? .black)
        
        guard let gradientImage = filter.outputImage?.cropped(to: ciImage.extent) else { return nil }
        
        let compositeFilter = CIFilter.multiplyBlendMode()
        compositeFilter.setValue(gradientImage, forKey: kCIInputImageKey)
        compositeFilter.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        
        guard let outputImage = compositeFilter.outputImage,
              let outputCGImage = context.createCGImage(outputImage, from: outputImage.extent)
        else { return nil }

        return UIImage(cgImage: outputCGImage)
    }
}
