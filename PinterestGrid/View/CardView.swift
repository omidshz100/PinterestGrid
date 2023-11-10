//
//  CardView.swift
//  PinterestGrid
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import SwiftUI

struct CardView: View {
    var size: CGSize
    var safeArea: EdgeInsets
    var item: Item
    var scale: CGFloat
    /// Environment Object
    @Environment(GridAnimationModel.self) var gridAnimation
    var body: some View {
        GeometryReader {
            let size = $0.size
            if let previewImage = item.previewImage {
                Image(uiImage: previewImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipShape(.rect(cornerRadius: 15))
            }
        }
        .frame(height: height)
        .opacity(gridAnimation.selectedItem?.id == item.id ? 0 : 1)
        .overlay {
            GeometryReader {
                let frame = $0.frame(in: .scrollView)
                let xAnchor = frame.minX / size.width
                /// 50: Header Height;
                let yAnchor = -(frame.minY + safeArea.top + 50.0)
                
                Rectangle()
                    .fill(.clear)
                    .contentShape(.rect)
                    .anchorPreference(key: RectKey.self, value: .bounds, transform: { anchor in
                        return [item.id.uuidString: anchor]
                    })
                    .onTapGesture {
                        Task {
                            gridAnimation.selectedRect = frame
                            gridAnimation.selectedItem = item
                            gridAnimation.overlayScale = scale
                            
                            gridAnimation.overlayImage = createScreenPreview()
                            
                            
                            if !gridAnimation.expandView {
                                gridAnimation.scaleAnchor = .init(x: xAnchor > 0.5 ? 1 : 0, y: 0)
                            }
                            
                            withAnimation(.easeInOut(duration: 0.35), completionCriteria: .logicallyComplete) {
                                if !gridAnimation.expandView {
                                    gridAnimation.offset = .init(width: xAnchor > 0.5 ? 15 : -15, height: yAnchor)
                                } else {
                                    gridAnimation.offset = .zero
                                }
                                gridAnimation.expandView.toggle()
                            } completion: {
                                if !gridAnimation.expandView {
                                    gridAnimation.scaleAnchor = .zero
                                }
                                
                                gridAnimation.hideView = true
                            }
                        }
                    }
            }
        }
    }
    
    var height: CGFloat {
        /// 40: 30 from Horizontal Padding; 10 From Grid Spacing
        let aspectSize = CGSize(width: (size.width - 40) / 2, height: size.height).aspectSize(from: size)
        return aspectSize.height
    }
}

#Preview {
    ContentView()
}
