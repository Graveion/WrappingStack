//
//  Row.swift
//  
//
//  Created by Tim Green on 16/12/2022.
//
import SwiftUI
import Foundation

internal class Row {
    var width: CGFloat
    let height: CGFloat

    var subviews: [LayoutSubview] = []

    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }

    func canFit(_ w: CGFloat) -> Bool {
        return width >= w
    }

    func addSubview(_ w: CGFloat, _ subview: LayoutSubview) {
        width -= w
        subviews.append(subview)
    }
}
