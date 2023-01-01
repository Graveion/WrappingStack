//
//  CachedContainer.swift
//  
//
//  Created by Tim Green on 01/01/2023.
//

import Foundation

public struct CachedContainer {
    var container: Container

    init(container: Container = EmptyContainer()) {
        self.container = container
    }
}
