//
//  AUIControl.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2017. 1. 19..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Foundation

public struct AUIControlState : OptionSet {
    let _rawValue: UInt
    
    public var rawValue: UInt {
        return _rawValue
    }
    
    public init(rawValue: UInt) {
        self._rawValue = rawValue
    }
    
    
    public static var normal: AUIControlState { return AUIControlState(rawValue: 0) }
    
    public static var highlighted: AUIControlState { return AUIControlState(rawValue: 0b1) } // used when UIControl isHighlighted is set
    
    public static var disabled: AUIControlState { return AUIControlState(rawValue: 0b10) }
    
    public static var selected: AUIControlState { return AUIControlState(rawValue: 0b100) } // flag usable by app (see below)
    
    public static var focused: AUIControlState { return AUIControlState(rawValue: 0b1000) } // Applicable only when the screen supports focus
    
    public static var application: AUIControlState { return AUIControlState(rawValue: 0b111111110000000000000000) } // additional flags available for application use
    
    public static var reserved: AUIControlState { return AUIControlState(rawValue: 0b11111111000000000000000000000000) } // flags reserved for internal framework use
}
