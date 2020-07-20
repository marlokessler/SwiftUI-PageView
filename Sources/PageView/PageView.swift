//
//  PageView.swift
//  ViewCTestApp
//
//  Created by Marlo Kessler on 18.07.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
public struct PageView<Content: View>: View {
    
    public init(pageCount: Int,
                currentIndex: Binding<Int> = Binding<Int>(get: {return 0}, set: {_ in}),
                @ViewBuilder content: @escaping () -> Content)
    {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content
    }
    
    private init(_ pageCount: Int,
                 _ currentIndex: Binding<Int>,
                 _ hideIndicator: Bool,
                 _ indicatorPosition: IndicatorPosition,
                 _ currentPageIndicatorColor: UIColor?,
                 _ indicatorColor: UIColor?,
                 _ indicatorBackgroundColor:Color?,
                 @ViewBuilder _ content: @escaping () -> Content)
    {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        
        self.hideIndicator = hideIndicator
        self.indicatorPosition = indicatorPosition
        self.currentPageIndicatorColor = currentPageIndicatorColor
        self.indicatorColor = indicatorColor
        self.indicatorBackgroundColor = indicatorBackgroundColor
        
        self.content = content
    }
    
    
    
    // MARK: - Variables
    private let pageCount: Int
    @Binding private var currentIndex: Int
    private let content: () -> Content

    @GestureState private var translation: CGFloat = 0
    
    private var hideIndicator: Bool = false
    private var indicatorPosition: IndicatorPosition = .bottomInBounds
    private var indicatorColor: UIColor?
    private var currentPageIndicatorColor: UIColor?
    private var indicatorBackgroundColor: Color?
    
    
    
    // MARK: - Methods
    public func indicator(position: IndicatorPosition = .bottomInBounds, current: UIColor? = nil, other: UIColor? = nil, background: Color? = nil) -> PageView {
        return PageView(pageCount, $currentIndex, hideIndicator, position, current, other, background, content)
    }
    
    public func hideIndicator(_ hide: Bool = true) -> PageView {
        return PageView(pageCount, $currentIndex, hide, indicatorPosition, currentPageIndicatorColor, indicatorColor, indicatorBackgroundColor, content)
    }
    
    
    
    // MARK: - View
    private var indicator: some View {
        PageIndicator(currentIndex: self.$currentIndex,
                pageNumber: self.pageCount,
                pageIndicatorColor: self.indicatorColor,
                currentPageIndicatorColor: self.currentPageIndicatorColor)
        .frame(height: 15)
        .padding(.horizontal, 8)
        .background(self.indicatorBackgroundColor ?? Color.clear.opacity(0.5))
        .clipped()
        .cornerRadius(7.5)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                
                if self.indicatorPosition == .topInBounds {
                    VStack {
                        self.indicator
                            .offset(y: 16)
                        Spacer()
                    }
                    .zIndex(1)
                }
                
            VStack {
                
                if self.indicatorPosition == .topOutBounds { self.indicator }
                
                HStack(spacing: 0) {
                    self.content().frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
                .offset(x: self.translation)
                .clipped()
                .animation(.interactiveSpring())
                .gesture(
                    DragGesture()
                    .updating(self.$translation) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let offset = value.translation.width / geometry.size.width
                        let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                        self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                    }
                )
                
                if self.indicatorPosition == .bottomOutBounds { self.indicator }
            }
                
                if self.indicatorPosition == .bottomInBounds {
                    VStack {
                        Spacer()
                        self.indicator
                            .offset(y: -16)
                    }
                }
                
            }
        }
    }
}
