//
//  LightShadowModifier.swift
//  WrappingStackExample
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation
import SwiftUI

struct LightShadow: ViewModifier {
    let color: Color

    func body(content: Content) -> some View {
        content
            .foregroundStyle(
                .shadow(
                    .drop(color: color, radius: 0.33, x: -0.30, y: 0.30)
                )
            )
    }
}

extension View {
    func lightShadow(color: Color = .secondary) -> some View {
        modifier(LightShadow(color: color))
    }
}
