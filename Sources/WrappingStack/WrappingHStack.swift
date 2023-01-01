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
    let edgeAlignment: EdgeAlignment
    let containerFactory: ContainerFactory

    /// - itemSpacing: The distance between adjacent subviews, defaults to 0
    /// - rowSpacing: The distance between each row
    /// - arrangement: Determines the order in which items are added
    public init(itemSpacing: CGFloat = 0,
                rowSpacing: CGFloat = 0,
                arrangement: Arrangement = .firstFit,
                edgeAlignment: EdgeAlignment = .centre,
                containerFactory: ContainerFactory = ContainerFactory()) {
        self.itemSpacing = itemSpacing
        self.rowSpacing = rowSpacing
        self.arrangement = arrangement
        self.containerFactory = containerFactory
        self.edgeAlignment = edgeAlignment
    }

    public func makeCache(subviews: Subviews) -> CachedContainer {
        CachedContainer()
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout CachedContainer) -> CGSize {

        guard let proposedWidth = proposal.width else { return CGSize() }

        // if we are centered then reduce width by itemSpacing
        // to give that room at the end of the line
        let realWidth = edgeAlignment == .centre ? proposedWidth - itemSpacing : proposedWidth

        // Use container to find out sizes
        cache.container = containerFactory.container(for: arrangement, with: realWidth)

        cache.container.fillContainer(subviews: subviews, spacing: itemSpacing)

        let calculatedHeight = cache.container.height + (CGFloat(cache.container.lines.count - 1) * rowSpacing)

        return CGSize(width: proposedWidth,
                      height: calculatedHeight)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CachedContainer) {

        var local = bounds

        // lets do centered as pre space, post space, then when calcs are done
        // find out what space is remaining, and split it evenly for that row over
        // post and pre

        // trailing is just reverse the signs

        // Use container to place views
        for (index, row) in cache.container.lines.enumerated() {

            var maxHeight: CGFloat = 0

            switch edgeAlignment {
            case .leading:
                local.origin.x = bounds.minX
            case .trailing:
                local.origin.x = bounds.maxX
            case .centre:
                local.origin.x = bounds.minX + itemSpacing
            }

            for subview in row.subviews {
                let subviewSize = subview.dimensions(in: proposal)

                switch edgeAlignment {
                case .leading:
                    subview.place(at: local.origin, proposal: proposal)
                    local.origin.x += (subviewSize.width + itemSpacing)
                case .trailing:
                    local.origin.x -= subviewSize.width
                    subview.place(at: local.origin, proposal: proposal)
                    local.origin.x -= itemSpacing
                case .centre:
                    // take the lines remaining width and distribute into the spaces between views
                    let distributableSpacing = (row.width / CGFloat(row.subviews.count - 1))

                    subview.place(at: local.origin, proposal: proposal)
                    local.origin.x += (subviewSize.width + itemSpacing + distributableSpacing)
                }

                // check if this subview is higher than the rest
                if subviewSize.height > maxHeight {
                    maxHeight = subviewSize.height
                }
            }

            // increment y by the largest height subview
            local.origin.y += maxHeight

            // apply line spacing - unless its the last line
            if (index != cache.container.lines.count - 1) {
                local.origin.y += rowSpacing
            }
        }
    }
}

public enum EdgeAlignment {
    case leading
    case trailing
    case centre
}
