//
//  ContainerFactory.swift
//  
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation
import SwiftUI

public struct ContainerFactory {

    public init() {}

    func container(for arrangement: Arrangement, with length: CGFloat, axis: Axis) -> Container {
        switch arrangement {
        case .nextFit:
            return NextFitContainer(length: length, axis: axis)
        case .bestFit:
            return BestFitContainer(length: length, axis: axis)
        case .firstFit:
            return FirstFitContainer(length: length, axis: axis)
        case .worstFit:
            return WorstFitContainer(length: length, axis: axis)
        }
    }
}
