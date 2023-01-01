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
