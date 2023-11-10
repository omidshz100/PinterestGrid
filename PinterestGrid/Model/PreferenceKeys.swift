//
//  PreferenceKeys.swift
//  PinterestGrid
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import Foundation

import SwiftUI

struct RectKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}


