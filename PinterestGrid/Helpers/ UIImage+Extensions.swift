//
//   UIImage+Extensions.swift
//  PinterestGrid
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import Foundation
import SwiftUI

extension UIImage? {
    /// Returns Optimized Image based on Screen Size
    func optimized() -> UIImage? {
        if let screenSize = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow })?.screen.bounds.size {
            let size = CGSize(width: screenSize.width * 0.5, height: screenSize.height * 0.5)
            let aspectSize = size.aspectSize(from: self?.size ?? size)
            
            let renderer = UIGraphicsImageRenderer(size: aspectSize)
            return renderer.image { _ in
                self?.draw(in: .init(origin: .zero, size: aspectSize))
            }
        }
        
        return self
    }
}
