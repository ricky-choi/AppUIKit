//
//  AUIBarItem.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUIBarItem: NSObject {
    public var isEnabled: Bool = false
    public var image: NSImage?
    public var landscapeImagePhone: NSImage?
    public var imageInsets: EdgeInsets = NSEdgeInsetsZero
    public var landscapeImagePhoneInsets: EdgeInsets = NSEdgeInsetsZero
    public var title: String?
    public var tag: Int = 0
}
