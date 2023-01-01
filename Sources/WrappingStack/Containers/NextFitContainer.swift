//
//  NextFitContainer.swift
//  
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation
import SwiftUI

internal class NextFitContainer: Container {
    internal var width: CGFloat
    internal var lines: [Line] = []
    private var currentLine: Line?

    init(width: CGFloat = 0, lines: [Line] = []) {
        self.width = width
        self.lines = lines
    }

    var height: CGFloat {
        lines.map { $0.height }.reduce(0.0, +)
    }

    private func newLine(height: CGFloat) -> Line {
        let newLine = Line(width: width, height: height)
        lines.append(newLine)
        currentLine = newLine
        return newLine
    }

    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat = 0) {
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            var itemWidth = size.width

            var currentLine = currentLine ?? newLine(height: size.height)

            // check alignments
            if !currentLine.subviews.isEmpty {
                itemWidth = size.width + spacing
            }

            // If the subview doesn't fit we need a new line
            if !currentLine.canFit(itemWidth) {
                currentLine = newLine(height: size.height)
            }

            currentLine.addSubview(itemWidth, subview)
        }
    }
}
