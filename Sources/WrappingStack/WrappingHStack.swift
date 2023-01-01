//
//  WrappingHStack.swift
//  
//
//  Created by Tim Green on 16/12/2022.
//

import Foundation
import SwiftUI

/// Horizontal Layout which wraps items onto a new line, wrapping algorithm is determined by arrangement
public struct WrappingHStack: Layout {
    let itemSpacing: CGFloat
    let rowSpacing: CGFloat
    let arrangement: Arrangement
    let containerFactory = ContainerFactory()

    /// - itemSpacing: The distance between adjacent subviews, defaults to 0
    /// - rowSpacing: The distance between each row
    /// - arrangement: Determines the order in which items are added
    public init(itemSpacing: CGFloat = 0, rowSpacing: CGFloat = 0, arrangement: Arrangement = .firstFit) {
        self.itemSpacing = itemSpacing
        self.rowSpacing = rowSpacing
        self.arrangement = arrangement
    }

    public func makeCache(subviews: Subviews) -> CachedContainer {
        CachedContainer()
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout CachedContainer) -> CGSize {

        guard let width = proposal.width else { return CGSize() }

        // Use container to find out sizes
        cache.container = containerFactory.container(for: arrangement, with: width)

        cache.container.fillContainer(subviews: subviews, spacing: itemSpacing)

        let calculatedHeight = cache.container.height + (CGFloat(cache.container.lines.count - 1) * rowSpacing)

        return CGSize(width: cache.container.width,
                      height: calculatedHeight)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CachedContainer) {

        var local = bounds

        // Use container to place views
        for (index, row) in cache.container.lines.enumerated() {

            var maxHeight: CGFloat = 0

            for subview in row.subviews {
                let subviewSize = subview.dimensions(in: proposal)
                subview.place(at: local.origin, proposal: proposal)

                local.origin.x += (subviewSize.width + itemSpacing)

//                // add spacing to everything but the last item
//                if (index != row.subviews.count - 1) {
//                    local.origin.x += itemSpacing
//                }

                if subviewSize.height > maxHeight {
                    maxHeight = subviewSize.height
                }
            }

            // Reset X position
            local.origin.x = bounds.minX


            // increment y by the largest height subview
            local.origin.y += maxHeight

            // apply spacing - unless its the last row
            if (index != cache.container.lines.count - 1) {
                local.origin.y += rowSpacing
            }
        }
    }
}

public enum Arrangement: String, CaseIterable {
    case nextFit
    case bestFit
    case firstFit
    case worstFit
}


