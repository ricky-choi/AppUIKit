//
//  AUIControl.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2017. 1. 19..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Foundation

public struct AUIControlState : OptionSet, Hashable {
    let _rawValue: UInt
    
    public var rawValue: UInt {
        return _rawValue
    }
    
    public init(rawValue: UInt) {
        self._rawValue = rawValue
    }
    
    public var hashValue: Int {
        return Int(_rawValue)
    }
    
    public static let normal: AUIControlState = AUIControlState(rawValue: 0)
    
    public static let highlighted: AUIControlState = AUIControlState(rawValue: 0b1) // used when UIControl isHighlighted is set
    
    public static let disabled: AUIControlState = AUIControlState(rawValue: 0b10)
    
    public static let selected: AUIControlState = AUIControlState(rawValue: 0b100) // flag usable by app (see below)
    
    public static let focused: AUIControlState = AUIControlState(rawValue: 0b1000) // Applicable only when the screen supports focus
    
    public static let application: AUIControlState = AUIControlState(rawValue: 0b111111110000000000000000) // additional flags available for application use
    
    public static let reserved: AUIControlState = AUIControlState(rawValue: 0b11111111000000000000000000000000) // flags reserved for internal framework use
    
    
    
    
    static let `default`: AUIControlState = .normal
    
    static let notDefaultStates: [AUIControlState] = [.highlighted, .disabled, .selected, .focused]
    
}
