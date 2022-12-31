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
        for (idx, subview) in subviews.enumerated() {
            var bestLine: Line?
            var bestWidth = width
            let size = subview.sizeThatFits(.unspecified)

            if subviews.first == subview {
                print("isFirst")
            }

            // If its not the last subview then apply a spacing
            let spacerWidth = (idx == subviews.count - 1)
            ? size.width
            : size.width + spacing

            // Loop through the rows and find the best fit for the subview
            for line in lines {
                // If the subview fits in the row and the row is narrower than the best fit so far, update the best fit
                if line.canFit(spacerWidth) && line.width < bestWidth {
                    bestLine = line
                    bestWidth = line.width
                }
            }

            // If a best fit was found, add the subview to the row
            if let bestLine = bestLine {
                bestLine.addSubview(spacerWidth, subview)
            } else {
                // If no best fit was found, create a new row and add the subview to it
                let newLine = Line(width: width, height: size.height)
                newLine.addSubview(spacerWidth, subview)
                lines.append(newLine)
            }
        }
    }
}

internal class NextFitContainer: Container {
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

        guard let size = subviews.first?.sizeThatFits(.unspecified)
        else { return }

        var currentLine = Line(width: width, height: size.height)
        lines.append(currentLine)

        for (idx, subview) in subviews.enumerated() {

            // If its not the last subview then apply a spacing
            let spacerWidth = (idx == subviews.count - 1)
            ? size.width
            : size.width + spacing

            // If the subview fits in the row add it
            if currentLine.canFit(spacerWidth) {
                currentLine.addSubview(spacerWidth, subview)
            } else {
                // If row is maxed out lets add a new row
                let newLine = Line(width: width, height: size.height)
                newLine.addSubview(spacerWidth, subview)
                lines.append(newLine)
                currentLine = newLine
            }

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

        for (idx, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)

            var foundLine: Line? = nil

            // If its not the last subview then apply a spacing
            let spacerWidth = (idx == subviews.count - 1)
            ? size.width
            : size.width + spacing

            // Loop through the rows and find the first fit for the subview
            for line in lines {
                // If the subview fits in the row append
                if line.canFit(spacerWidth) {
                    foundLine = line
                    break
                }
            }

            if let foundLine = foundLine {
                foundLine.addSubview(spacerWidth, subview)
            } else {
                // If no fit was found, create a new row and add the subview to it
                let newLine = Line(width: width, height: size.height)
                lines.append(newLine)
                newLine.addSubview(spacerWidth, subview)
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
