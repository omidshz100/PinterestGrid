//
//  UIView+Extensions.swift
//  PinterestGrid
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import Foundation
import SwiftUI

extension UIView {
    /// Converts UIView into UIImage
    func image(_ size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            drawHierarchy(in: .init(origin: .zero, size: size), afterScreenUpdates: true)
        }
    }
}
