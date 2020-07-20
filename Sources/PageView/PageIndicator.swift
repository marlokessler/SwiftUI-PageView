//
//  PageIndicator.swift
//  ViewCTestApp
//
//  Created by Marlo Kessler on 20.07.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
struct PageIndicator: UIViewRepresentable {

    @Binding var currentIndex: Int
    var pageNumber: Int
    var pageIndicatorColor: UIColor?
    var currentPageIndicatorColor: UIColor?

    private let pageControl = UIPageControl()

    func makeUIView(context: Context) -> UIPageControl {
        pageControl.numberOfPages = pageNumber
        if let color = pageIndicatorColor{ pageControl.pageIndicatorTintColor = color }
        if let color = currentPageIndicatorColor{ pageControl.currentPageIndicatorTintColor = color }
        pageControl.addTarget(context.coordinator, action: #selector(context.coordinator.change), for: .valueChanged)
        return pageControl
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentIndex
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator {

        init(parent: PageIndicator) {
            self.parent = parent
        }

        private let parent: PageIndicator

        @objc func change() {
            parent.currentIndex = parent.pageControl.currentPage
        }
    }
}
