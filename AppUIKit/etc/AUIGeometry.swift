//
//  AUIGeometry.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2017. 1. 18..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Foundation

public struct AUIOffset {
    
    public var horizontal: CGFloat // specify amount to offset a position, positive for right or down, negative for left or up
    
    public var vertical: CGFloat
    
    public init() {
        self.horizontal = 0
        self.vertical = 0
    }
    
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

extension AUIOffset {
    public static var zero: AUIOffset { return AUIOffset() }
}

extension AUIOffset : Equatable {
}

public func ==(lhs: AUIOffset, rhs: AUIOffset) -> Bool {
    return lhs.horizontal == rhs.horizontal && lhs.vertical == rhs.vertical
}
