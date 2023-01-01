//
//  Container.swift
//  
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation
import SwiftUI

internal protocol Container {
    var width: CGFloat { get }
    var height: CGFloat { get }
    var lines: [Line] { get }
    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat)
}

internal struct EmptyContainer: Container {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var lines: [Line] = []
    func fillContainer(subviews: LayoutSubviews, spacing: CGFloat) {}
}
