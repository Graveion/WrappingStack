//
//  FirstFitContainer.swift
//  
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation
import SwiftUI

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
