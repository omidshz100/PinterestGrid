//
//  DetailView.swift
//  PinterestGrid
//
//  Created by Omid Shojaeian Zanjani on 10/11/23.
//

import SwiftUI

struct DetailView: View {
    var selectedItem: Item
    var size: CGSize
    var rect: CGRect
    /// Environment Object
    @Environment(GridAnimationModel.self) private var gridAnimation
    /// View Properties
    @State private var showBottomContent: Bool = false
    var body: some View {
        Group {
            /// Scaling Animation View
            if let overlayImage = gridAnimation.overlayImage, !gridAnimation.hideView {
                Image(uiImage: overlayImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
                    .opacity(gridAnimation.opacity)
                    .overlay(alignment: .topLeading, content: {
                        GeometryReader { _ in
                            if let previewImage = selectedItem.previewImage {
                                Image(uiImage: previewImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: rect.width, height: rect.height)
                                    .clipShape(.rect(cornerRadius: 15))
                                    .offset(x: rect.minX, y: rect.minY)
                            }
                        }
                    })
                    .offset(gridAnimation.offset)
                    .scaleEffect(
                        gridAnimation.expandView ? gridAnimation.overlayScale : 1,
                        anchor: .init(
                            x: gridAnimation.scaleAnchor.x,
                            y: gridAnimation.scaleAnchor.y
                        )
                    )
                    .offset(y: gridAnimation.expandView ? safeAreaRegions.top : 0)
            }
            
            /// Actual Detail View
            if gridAnimation.hideView {
                GeometryReader { proxy in
                    ImageView(size: proxy.size)
                        .overlay(alignment: .topLeading) {
                            HStack {
                                Button(action: closeView, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white, Color.black)
                                })
                                
                                Spacer()
                                
                                Button(action: {  }, label: {
                                    Image(systemName: "arrow.down.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white, Color.black)
                                })
                            }
                            .buttonStyle(.plain)
                            .padding()
                            .opacity(gridAnimation.hideView ? 1 : 0)
                            .animation(.snappy(duration: 0.2), value: gridAnimation.hideView)
                        }
                }
                .padding(.top, safeAreaRegions.top)
                .padding(.bottom, safeAreaRegions.bottom)
                .frame(width: size.width, height: size.height)
                .sheet(isPresented: $showBottomContent) {
                    SheetContent()
                        .presentationDetents([.large, .medium, .height(100)])
                        .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                        .presentationCornerRadius(30)
                        .interactiveDismissDisabled()
                }
                .onAppear {
                    guard !showBottomContent else { return }
                    showBottomContent = true
                }
            }
        }
    }
    
    /// Expanded Image View
    @ViewBuilder
    func ImageView(size: CGSize) -> some View {
        if let originalImage = selectedItem.originalImage {
            Image(uiImage: originalImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipShape(.rect(cornerRadius: 15 * gridAnimation.overlayScale))
        }
    }
    
    /// Bottom Sheet Content
    @ViewBuilder
    func SheetContent() -> some View {
        VStack {
            Text(selectedItem.title)
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 15)
        }
        .padding(15)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    /// Close Triggerer
    func closeView() {
        showBottomContent = false
        gridAnimation.hideView = false
        
        withAnimation(.easeInOut(duration: 0.35), completionCriteria: .logicallyComplete) {
            gridAnimation.offset = .zero
            gridAnimation.expandView = false
        } completion: {
            gridAnimation.scaleAnchor = .zero
            gridAnimation.selectedItem = nil
            gridAnimation.overlayImage = nil
        }
    }
}

#Preview {
    ContentView()
}
