//
//  Line.swift
//  
//
//  Created by Tim Green on 16/12/2022.
//
import SwiftUI
import Foundation

internal class Line {
    var length: CGFloat

    var subviews: [LayoutSubview] = []

    init(length: CGFloat) {
        self.length = length
    }

    func canFit(_ w: CGFloat) -> Bool {
        return length >= w
    }

    func addSubview(_ w: CGFloat, _ subview: LayoutSubview) {
        length -= w
        subviews.append(subview)
    }
}
