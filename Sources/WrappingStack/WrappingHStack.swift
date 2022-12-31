//
//  WrappingHStack.swift
//  
//
//  Created by Tim Green on 16/12/2022.
//

import Foundation
import SwiftUI

/// Horizontal Layout which wraps items onto a new line, wrapping style is determined by arrangement
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
            if (index != cache.container.lines.count - 1) {
                local.origin.y += rowSpacing
            }
        }
    }
}

public struct CachedContainer {
    var container: Container

    init(container: Container = EmptyContainer()) {
        self.container = container
    }
}

public enum Arrangement {
    case nextFit
    case bestFit
    case firstFit
}

public struct ContainerFactory {
    func container(for arrangement: Arrangement, with width: CGFloat) -> Container {
        switch arrangement {
        case .nextFit:
            return NextFit(width: width)
        case .bestFit:
            return BestFitContainer(width: width)
        case .firstFit:
            return FirstFitContainer(width: width)
        }
    }
}
