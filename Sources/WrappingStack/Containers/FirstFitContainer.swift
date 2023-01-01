//
//  FirstFitContainer.swift
//  
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation
import SwiftUI

internal class FirstFitContainer: Container {
    internal var length: CGFloat
    internal var lines: [Line] = []
    internal var axis: Axis

    init(length: CGFloat = 0, axis: Axis = .horizontal) {
        self.length = length
        self.axis = axis
    }

    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat = 0) {
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            let itemLength = axis == .horizontal ? size.width + spacing : size.height + spacing

            var foundLine: Line? = nil

            // Loop through the rows and find the first fit for the subview
            for line in lines {
                // If the subview fits in the row append
                if line.canFit(itemLength) {
                    foundLine = line
                    break
                }
            }

            if let foundLine = foundLine {
                foundLine.addSubview(itemLength, subview)
            } else {
                // If no fit was found, create a new row and add the subview to it
                let newLine = Line(length: length)
                lines.append(newLine)
                newLine.addSubview(itemLength, subview)
            }
        }
    }
}
