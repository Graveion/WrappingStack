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
    let lineSpacing: CGFloat
    let arrangement: Arrangement
    let edgeAlignment: EdgeAlignment
    let containerFactory: ContainerFactory

    /// Arranges views horizontally and creates a new row when an item exceeds the allowed spacing
    /// - Parameters:
    ///    - itemSpacing: The distance between adjacent subviews, defaults to 0
    ///    - rowSpacing: The distance between each row
    ///    - arrangement: Determines the order in which items are added
    ///    - edgeAlignment: Aligns views to an edge or centrally
    public init(itemSpacing: CGFloat = 0,
                lineSpacing: CGFloat = 0,
                arrangement: Arrangement = .firstFit,
                edgeAlignment: EdgeAlignment = .leading,
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

        guard let proposedWidth = proposal.width else { return CGSize() }

        var realWidth = proposedWidth

        switch edgeAlignment {
        case .justified:
            realWidth -= itemSpacing
        case .centre:
            realWidth += itemSpacing
        default:
            break
        }

        cache.container = containerFactory.container(for: arrangement, with: realWidth, axis: .horizontal)

        cache.container.fillContainer(subviews: subviews, spacing: itemSpacing)

        let calculatedHeight = cache.container.perpendicular() + (CGFloat(cache.container.lines.count - 1) * lineSpacing)

        return CGSize(width: proposedWidth,
                      height: calculatedHeight)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CachedContainer) {

        var local = bounds

        // Use container to place views
        for (index, row) in cache.container.lines.enumerated() {

            var maxHeight: CGFloat = 0

            switch edgeAlignment {
            case .leading:
                local.origin.x = bounds.minX
            case .trailing:
                local.origin.x = bounds.maxX
            case .justified:
                local.origin.x = bounds.minX + itemSpacing
            case .centre:
                local.origin.x = bounds.minX + (row.length / 2.0)
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
                case .justified:
                    // take the lines remaining width and distribute into the spaces between views
                    let distributableSpacing = (row.length / CGFloat(row.subviews.count - 1))

                    subview.place(at: local.origin, proposal: proposal)
                    local.origin.x += (subviewSize.width + itemSpacing + distributableSpacing)
                case .centre:
                    subview.place(at: local.origin, proposal: proposal)
                    local.origin.x += (subviewSize.width + itemSpacing)
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
                local.origin.y += lineSpacing
            }
        }
    }
}

public enum EdgeAlignment: String, CaseIterable {
    case leading
    case trailing
    case justified
    case centre
}
