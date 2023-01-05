//
//  WrappingVStack.swift
//  
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation
import SwiftUI

/// Horizontal Layout which wraps items onto a new line, wrapping algorithm is determined by arrangement
public struct WrappingVStack: Layout {
    let itemSpacing: CGFloat
    let lineSpacing: CGFloat
    let arrangement: Arrangement
    let edgeAlignment: EdgeAlignment
    let containerFactory: ContainerFactory

    /// - itemSpacing: The distance between adjacent subviews, defaults to 0
    /// - rowSpacing: The distance between each row
    /// - arrangement: Determines the order in which items are added
    public init(itemSpacing: CGFloat = 0,
                lineSpacing: CGFloat = 0,
                arrangement: Arrangement = .firstFit,
                edgeAlignment: EdgeAlignment = .justified,
                containerFactory: ContainerFactory = ContainerFactory()) {
        self.itemSpacing = itemSpacing
        self.lineSpacing = lineSpacing
        self.arrangement = arrangement
        self.containerFactory = containerFactory
        self.edgeAlignment = edgeAlignment
    }

    public func makeCache(subviews: Subviews) -> CachedContainer {
        CachedContainer()
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout CachedContainer) -> CGSize {

        guard let proposedHeight = proposal.height else { return CGSize() }

        var length = proposedHeight

        switch edgeAlignment {
        case .justified:
            length -= itemSpacing
        default:
            length += itemSpacing
        }

        // Use container to find out sizes
        cache.container = containerFactory.container(for: arrangement, with: length, axis: .vertical)

        cache.container.fillContainer(subviews: subviews, spacing: itemSpacing)

        let calculatedWidth = cache.container.perpendicular() + (CGFloat(cache.container.lines.count - 1) * lineSpacing)

        return CGSize(width: calculatedWidth,
                      height: proposedHeight)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CachedContainer) {

        var local = bounds

        // Use container to place views
        for (index, row) in cache.container.lines.enumerated() {

            var maxWidth: CGFloat = 0

            switch edgeAlignment {
            case .leading:
                local.origin.y = bounds.minY
            case .trailing:
                local.origin.y = bounds.maxY
            case .justified:
                local.origin.y = bounds.minY + itemSpacing

            case .centre:
                local.origin.y = bounds.minY + row.length
            }

            for subview in row.subviews {
                let subviewSize = subview.dimensions(in: proposal)

                switch edgeAlignment {
                case .leading:
                    subview.place(at: local.origin, proposal: proposal)
                    local.origin.y += (subviewSize.height + itemSpacing)
                case .trailing:
                    local.origin.y -= subviewSize.height
                    subview.place(at: local.origin, proposal: proposal)
                    local.origin.y -= itemSpacing
                case .justified:
                    let distributableSpacing = (row.length / CGFloat(row.subviews.count - 1))
                    subview.place(at: local.origin, proposal: proposal)
                    local.origin.y += (subviewSize.height + itemSpacing + distributableSpacing)
                case .centre:
                    subview.place(at: local.origin, proposal: proposal)
                    local.origin.y += (subviewSize.height + itemSpacing)
                }

                // check if this subview is wider than the rest
                if subviewSize.width > maxWidth {
                    maxWidth = subviewSize.width
                }
            }

            // increment x by the largest height subview
            local.origin.x += maxWidth

            // apply line spacing - unless its the last line
            if (index != cache.container.lines.count - 1) {
                local.origin.x += lineSpacing
            }
        }
    }
}
