//
//  BestFitContainer.swift
//  
//
//  Created by Tim Green on 16/12/2022.
//

import Foundation
import SwiftUI

internal class BestFitContainer: Container {
    internal var width: CGFloat
    internal var lines: [Line] = []

    init(width: CGFloat = 0, lines: [Line] = []) {
        self.width = width
        self.lines = lines
    }

    var height: CGFloat {
        lines.map { $0.height }.reduce(0.0, +)
    }

    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat = 0) {
        for subview in subviews {
            var bestLine: Line?
            var bestWidth = width
            let size = subview.sizeThatFits(.unspecified)
            let itemWidth = size.width + spacing

            // Loop through the rows and find the best fit for the subview
            for line in lines {

                // If the subview fits in the row and the row is narrower than the best fit so far, update the best fit
                if line.canFit(itemWidth) && line.width < bestWidth {
                    bestLine = line
                    bestWidth = line.width
                }
            }

            // If a best fit was found, add the subview to the row
            if let bestLine = bestLine {
                bestLine.addSubview(itemWidth, subview)
            } else {
                // If no best fit was found, create a new row and add the subview to it
                let newLine = Line(width: width, height: size.height)
                newLine.addSubview(itemWidth, subview)
                lines.append(newLine)
            }
        }
    }
}

internal class WorstFitContainer: Container {
    internal var width: CGFloat
    internal var lines: [Line] = []

    init(width: CGFloat = 0, lines: [Line] = []) {
        self.width = width
        self.lines = lines
    }

    var height: CGFloat {
        lines.map { $0.height }.reduce(0.0, +)
    }

    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat = 0) {
        for subview in subviews {
            var bestLine: Line?
            var bestWidth = 0.0
            let size = subview.sizeThatFits(.unspecified)
            let itemWidth = size.width + spacing

            // Loop through the rows and find the best fit for the subview
            for line in lines {

                // If the subview fits in the row and the row is narrower than the best fit so far, update the best fit
                if line.canFit(itemWidth) && line.width > bestWidth {
                    bestLine = line
                    bestWidth = line.width
                }
            }

            // If a best fit was found, add the subview to the row
            if let bestLine = bestLine {
                bestLine.addSubview(itemWidth, subview)
            } else {
                // If no fit was found, create a new row and add the subview to it
                let newLine = Line(width: width, height: size.height)
                newLine.addSubview(itemWidth, subview)
                lines.append(newLine)
            }
        }
    }
}

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

internal class FirstFitContainer: Container {
    internal var width: CGFloat
    internal var lines: [Line] = []

    init(width: CGFloat = 0, rows: [Line] = []) {
        self.width = width
        self.lines = rows
    }

    var height: CGFloat {
        lines.map { $0.height }.reduce(0.0, +)
    }

    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat = 0) {

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            let itemWidth = size.width + spacing

            var foundLine: Line? = nil

            // Loop through the rows and find the first fit for the subview
            for line in lines {
                // If the subview fits in the row append
                if line.canFit(itemWidth) {
                    foundLine = line
                    break
                }
            }

            if let foundLine = foundLine {
                foundLine.addSubview(itemWidth, subview)
            } else {
                // If no fit was found, create a new row and add the subview to it
                let newLine = Line(width: width, height: size.height)
                lines.append(newLine)
                newLine.addSubview(itemWidth, subview)
            }
        }
    }
}

internal protocol Container {
    var width: CGFloat { get }
    var height: CGFloat { get }
    var lines: [Line] { get }
    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat)
}

internal struct EmptyContainer: Container {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var lines: [Line] = []
    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat) {}
}
