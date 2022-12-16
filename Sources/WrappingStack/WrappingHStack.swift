//
//  WrappingHStack.swift
//  
//
//  Created by Tim Green on 16/12/2022.
//

import Foundation
import SwiftUI

public struct WrappingHStack: Layout {
    let itemSpacing: CGFloat
    let rowSpacing: CGFloat

    public init(itemSpacing: CGFloat = 0 , rowSpacing: CGFloat = 0) {
        self.itemSpacing = itemSpacing
        self.rowSpacing = rowSpacing
    }

    public func makeCache(subviews: Subviews) -> CachedContainer {
        CachedContainer(container: Container(width: 0))
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout CachedContainer) -> CGSize {
        // Use container to find out sizes
        cache.container = Container(width: proposal.width ?? 0)

        cache.container.fillContainer(subviews: subviews, spacing: itemSpacing)

        let calculatedHeight = cache.container.height + (CGFloat(cache.container.rows.count - 1) * rowSpacing)

        return CGSize(width: cache.container.width,
                      height: calculatedHeight)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CachedContainer) {

        var local = bounds

        // Use container to place views
        for (index, row) in cache.container.rows.enumerated() {

            var maxHeight: CGFloat = 0

            for (index, subview) in row.subviews.enumerated() {
                let subviewSize = subview.dimensions(in: proposal)
                subview.place(at: local.origin, proposal: proposal)

                local.origin.x += subviewSize.width

                // add spacing to everything but the last item
                if (index != row.subviews.count - 1) {
                    local.origin.x += itemSpacing
                }

                if subviewSize.height > maxHeight {
                    maxHeight = subviewSize.height
                }
            }

            // Reset X position
            local.origin.x = bounds.minX

            // TODO:
            // Find a better way to track max heights
            // via sizethatfits and the cache?
            local.origin.y += maxHeight

            // TODO:
            // Find a better way to
            // only apply spacing in between rows
            // not on the last
            if (index != cache.container.rows.count - 1) {
                local.origin.y += rowSpacing
            }
        }
    }
}

public struct CachedContainer {
    var container: Container
}
