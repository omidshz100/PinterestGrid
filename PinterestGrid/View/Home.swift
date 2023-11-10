//
//  Home.swift
//  PinterestGrid
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import SwiftUI

struct Home: View {
    var gridAnimation = GridAnimationModel()
    @State private var images = sampleImages
    var body: some View {
        GeometryReader(content: { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets
            /// 40: 30 from Horizontal Padding; 10 From Grid Spacing
            let aspectSize = CGSize(width: (size.width - 40) / 2, height: size.height).aspectSize(from: size)
            let scale = size.height / aspectSize.height
            
            VStack(spacing: 0) {
                Text("All")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.gray.opacity(0.12))
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 2), spacing: 10, content: {
                        ForEach($images) { $item in
                            CardView(
                                size: size,
                                safeArea: safeArea,
                                item: item,
                                scale: scale
                            )
                            .environment(gridAnimation)
                            .onAppear {
                                createOptimizedImage(item: $item)
                            }
                        }
                    })
                    .padding(15)
                }
                .scrollIndicators(.hidden)
            }
        })
        .opacity(gridAnimation.overlayImage == nil ? 1 : 0)
        .overlayPreferenceValue(RectKey.self, { value in
            GeometryReader { proxy in
                let size = proxy.size
                
                if let selectedItem = gridAnimation.selectedItem, let anchor = value[selectedItem.id.uuidString] {
                    let rect = proxy[anchor]
                    
                    DetailView(
                        selectedItem: selectedItem,
                        size: size,
                        rect: rect
                    )
                    .environment(gridAnimation)
                }
            }
            .ignoresSafeArea()
        })
        /// Don't Remove this!
        .onChange(of: gridAnimation.offset, { oldValue, newValue in
            withAnimation(.snappy.delay(newValue == .zero ? 0 : 0.17)) {
                gridAnimation.opacity = newValue != .zero ? 0 : 1
            }
        })
    }
    
    /// Creating Optimized Preview Image
    func createOptimizedImage(item: Binding<Item>) {
        guard item.wrappedValue.previewImage == nil else { return }
        item.wrappedValue.previewImage = item.wrappedValue.originalImage.optimized()
    }
}

#Preview {
    ContentView()
}
