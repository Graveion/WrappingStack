//
//  NextFitContainer.swift
//  
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation
import SwiftUI

internal class NextFitContainer: Container {
    internal var length: CGFloat
    internal var lines: [Line] = []
    internal var axis: Axis

    private var currentLine: Line?

    init(length: CGFloat = 0, axis: Axis = .horizontal) {
        self.length = length
        self.axis = axis
    }

    private func newLine() -> Line {
        let newLine = Line(length: length)
        lines.append(newLine)
        currentLine = newLine
        return newLine
    }

    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat = 0) {
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            let itemLength = axis == .horizontal ? size.width + spacing : size.height + spacing

            var currentLine = currentLine ?? newLine()

            // If the subview doesn't fit we need a new line
            if !currentLine.canFit(itemLength) {
                currentLine = newLine()
            }

            currentLine.addSubview(itemLength, subview)
        }
    }
}
