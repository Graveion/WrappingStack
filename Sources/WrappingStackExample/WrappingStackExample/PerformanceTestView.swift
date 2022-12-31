//
//  PerformanceTestView.swift
//  WrappingStackExample
//
//  Created by Tim Green on 27/12/2022.
//

import SwiftUI
import WrappingStack

struct PerformanceTestView: View {

    var viewCount: Double = 1
    var itemSpacing: CGFloat = 5
    var rowSpacing: CGFloat = 5
    var arrangement: Arrangement = .firstFit

    var body: some View {
        WrappingStackExample(viewCount: viewCount,
                             rowSpacing: rowSpacing,
                             itemSpacing: itemSpacing,
                             arrangement: arrangement)
    }
}

struct PerformanceTestView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceTestView()
    }
}
