//
//  ContainerFactory.swift
//  
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation

public struct ContainerFactory {

    public init() {}

    func container(for arrangement: Arrangement, with width: CGFloat) -> Container {
        switch arrangement {
        case .nextFit:
            return NextFitContainer(width: width)
        case .bestFit:
            return BestFitContainer(width: width)
        case .firstFit:
            return FirstFitContainer(width: width)
        case .worstFit:
            return WorstFitContainer(width: width)
        }
    }
}
