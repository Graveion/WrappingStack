//
//  BestFitContainer.swift
//  
//
//  Created by Tim Green on 16/12/2022.
//

import Foundation
import SwiftUI

internal class BestFitContainer: Container {
    internal var length: CGFloat
    internal var lines: [Line] = []
    internal var axis: Axis

    init(length: CGFloat = 0, axis: Axis = .horizontal) {
        self.length = length
        self.axis = axis
    }

    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat = 0) {
        for subview in subviews {
            var bestLine: Line?
            var bestWidth = length
            let size = subview.sizeThatFits(.unspecified)
            let itemLength = axis == .horizontal ? size.width + spacing : size.height + spacing

            // Loop through the rows and find the best fit for the subview
            for line in lines {

                // If the subview fits in the row and the row is narrower than the best fit so far, update the best fit
                if line.canFit(itemLength) && line.length < bestWidth {
                    bestLine = line
                    bestWidth = line.length
                }
            }

            // If a best fit was found, add the subview to the row
            if let bestLine = bestLine {
                bestLine.addSubview(itemLength, subview)
            } else {
                // If no best fit was found, create a new row and add the subview to it
                let newLine = Line(length: length)
                newLine.addSubview(itemLength, subview)
                lines.append(newLine)
            }
        }
    }
}
