//
//  Item.swift
//  PinterestGrid
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import Foundation

import SwiftUI

struct Item: Identifiable, Hashable {
    private(set) var id: UUID = .init()
    var title: String
    /// Optimized Image for Preview
    var previewImage: UIImage?
    /// Actual Image
    var originalImage: UIImage?
}

var sampleImages: [Item] = [
    /// Image Link: https://www.pexels.com/photo/river-and-lake-behind-18970192/
    .init(title: "Abril Altamirano", originalImage: UIImage(named: "Pic 1")),
    /// Image Link: https://www.pexels.com/photo/hot-air-balloons-flying-in-cappadocia-at-sunrise-18873058/
    .init(title: "Gülşah Aydoğan", originalImage: UIImage(named: "Pic 2")),
    /// Image Link: https://www.pexels.com/photo/winter-landscape-with-wooden-cottage-in-snowy-forest-8001019/
    .init(title: "Melike Sayar Melikesayar", originalImage: UIImage(named: "Pic 3")),
    /// Image Link: https://www.pexels.com/photo/branches-with-green-leaves-in-nature-8058776/
    .init(title: "Maahid Photos", originalImage: UIImage(named: "Pic 4")),
    /// Image Link: https://www.pexels.com/photo/bush-with-green-fern-leaves-7945985/
    .init(title: "Pelageia Zelenina", originalImage: UIImage(named: "Pic 5")),
    /// Image Link: https://www.pexels.com/photo/tree-growing-among-agricultural-field-in-countryside-7939089/
    .init(title: "Ofir Eliav", originalImage: UIImage(named: "Pic 6")),
    /// Image Link: https://www.pexels.com/photo/scenic-landscape-of-autumn-forest-with-tall-trees-in-fog-8001169/
    .init(title: "Melike Sayar Melikesayar", originalImage: UIImage(named: "Pic 7")),
    /// Image Link: https://www.pexels.com/photo/winter-forest-with-river-and-wooden-footbridge-8000786/
    .init(title: "Melike Sayar Melikesayar", originalImage: UIImage(named: "Pic 8")),
    /// Image Link: https://www.pexels.com/photo/old-city-with-illuminated-buildings-and-roads-at-night-8000995/
    .init(title: "Melike Sayar Melikesayar", originalImage: UIImage(named: "Pic 9")),
    /// Image Link: https://www.pexels.com/photo/shore-with-dried-grass-near-river-7724075/
    .init(title: "Erik Mclean", originalImage: UIImage(named: "Pic 10")),
    /// Image Link: https://www.pexels.com/photo/person-hand-with-bouquet-of-flowers-on-narrow-footbridge-9387799/
    .init(title: "Fatma DELİASLAN", originalImage: UIImage(named: "Pic 11")),
]
