//
//  DeviceInfo.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 1..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Foundation

public enum IDeviceSize {
    case iPhoneEarly
    case iPhone4
    case iPhone5
    case iPhone7
    case iPhone7Plus
    
    public var size: NSSize {
        switch self {
        case .iPhoneEarly:
            return NSSize(width: 320, height: 480)
        case .iPhone4:
            return NSSize(width: 320, height: 480)
        case .iPhone5:
            return NSSize(width: 320, height: 586)
        case .iPhone7:
            return NSSize(width: 375, height: 667)
        case .iPhone7Plus:
            return NSSize(width: 414, height: 736)
        }
    }
    
    public var portraitSize: NSSize {
        return size;
    }
    
    public var landscapeSize: NSSize {
        return NSSize(width: size.height, height: size.width)
    }
    
    public var scale: Float {
        switch self {
        case .iPhoneEarly:
            return 1
        case .iPhone4:
            fallthrough
        case .iPhone5:
            fallthrough
        case .iPhone7:
            return 2
        case .iPhone7Plus:
            return 3
        }
    }
}
