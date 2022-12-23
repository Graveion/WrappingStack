//
//  File 3.swift
//  
//
//  Created by Tim Green on 16/12/2022.
//

import Foundation
import SwiftUI

internal class BestFitContainer: Container {
    internal var width: CGFloat
    internal var rows: [Row] = []

    init(width: CGFloat = 0, rows: [Row] = []) {
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

internal class OrderedContainer: Container {
    internal var width: CGFloat
    internal var rows: [Row] = []

    init(width: CGFloat = 0, rows: [Row] = []) {
        self.width = width
        self.rows = rows
    }

    var height: CGFloat {
        rows.map { $0.height }.reduce(0.0, +)
    }

    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat = 0) {

        guard let size = subviews.first?.sizeThatFits(.unspecified)
        else { return }

        var currentRow = Row(width: width, height: size.height)
        rows.append(currentRow)

        for (idx, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)

            // If its not the last subview then apply a spacing
            let spacerWidth = (idx == subviews.count - 1)
            ? size.width
            : size.width + spacing

            // If the subview fits in the row add it
            if currentRow.canFit(spacerWidth) {
                currentRow.addSubview(spacerWidth, subview)
            } else {
                // If row is maxed out lets add a new row
                let newRow = Row(width: width, height: size.height)
                newRow.addSubview(spacerWidth, subview)
                rows.append(newRow)
                currentRow = newRow
            }

        }
    }
}



internal protocol Container {
    var width: CGFloat { get }
    var height: CGFloat { get }
    var rows: [Row] { get }
    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat)
}

struct EmptyContainer: Container {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var rows: [Row] = []
    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat) {}
}