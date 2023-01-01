//
//  Container.swift
//  
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation
import SwiftUI

internal protocol Container {
    var length: CGFloat { get }
    var lines: [Line] { get }
    var axis: Axis { get }
    func perpendicular() -> CGFloat
    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat)
}

internal struct EmptyContainer: Container {
    var length: CGFloat = 0.0
    var lines: [Line] = []
    var axis: Axis = .horizontal
    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat) {}
}

extension Container {
    func perpendicular() -> CGFloat {
        if axis == .horizontal {
            return lines.compactMap {
                $0.subviews.map{ $0.sizeThatFits(.unspecified).height }.max()
            }.reduce(0.0, +)
        } else {
            return lines.compactMap {
                $0.subviews.map{ $0.sizeThatFits(.unspecified).width }.max()
            }.reduce(0.0, +)
        }
    }
}
