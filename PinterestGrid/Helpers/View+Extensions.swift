//
//  View+Extensions.swift
//  PinterestGrid
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import Foundation
import SwiftUI

extension View {
    /// Capturing Screen for Grid Animation
    func createScreenPreview() -> UIImage? {
        if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first {
            let frame = window.frame
            
            let image = window.image(frame.size)
            return image
        }
        
        return nil
    }
    
    /// Safe Area Values
    var safeAreaRegions: UIEdgeInsets {
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
}
