//
//  File 3.swift
//  
//
//  Created by Tim Green on 16/12/2022.
//

import Foundation
import SwiftUI

internal class Container {
    let width: CGFloat
    var rows: [Row]

    init(width: CGFloat, rows: [Row] = []) {
        self.width = width
        self.rows = rows
    }

    var height: CGFloat {
        rows.map { $0.height }.reduce(0.0, +)
    }

    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat = 0) {

        for (idx, subview) in subviews.enumerated() {
            var bestRow: Row?
            var bestWidth = width
            let size = subview.sizeThatFits(.unspecified)

            // If its not the last subview then apply a spacing
            let spacerWidth = (idx == subviews.count - 1)
            ? size.width
            : size.width + spacing

            // Loop through the rows and find the best fit for the subview
            for row in rows {
                // If the subview fits in the row and the row is narrower than the best fit so far, update the best fit
                if row.canFit(spacerWidth) && row.width < bestWidth {
                    bestRow = row
                    bestWidth = row.width
                }
            }

            // If a best fit was found, add the subview to the row
            if let bestRow = bestRow {
                bestRow.addSubview(spacerWidth, subview)
            } else {
                // If no best fit was found, create a new row and add the subview to it
                let newRow = Row(width: width, height: size.height)
                newRow.addSubview(spacerWidth, subview)
                rows.append(newRow)
            }
        }
    }
}
