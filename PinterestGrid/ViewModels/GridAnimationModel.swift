//
//  GridAnimationModel.swift
//  PinterestGrid
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import Foundation

import SwiftUI

@Observable
class GridAnimationModel {
    var expandView: Bool = false
    /// Animation Scale
    var scaleAnchor: CGPoint = .zero
    /// Animation Offset
    var offset: CGSize = .zero
    /// Snapshot Image for Scaling Animation
    var overlayImage: UIImage?
    /// Snapshot Image Opacity
    var opacity: CGFloat = 1
    /// Animation Scale
    var overlayScale: CGFloat = 1
    var hideView: Bool = false
    /// Selected Item and It's Position in the GridView
    var selectedItem: Item?
    var selectedRect: CGRect = .zero
}
