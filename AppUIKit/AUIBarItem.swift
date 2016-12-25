//
//  AUIBarItem.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUIBarItem: NSObject {
    var isEnabled: Bool = false
    var image: NSImage?
    var landscapeImagePhone: NSImage?
    var imageInsets: EdgeInsets = NSEdgeInsetsZero
    var landscapeImagePhoneInsets: EdgeInsets = NSEdgeInsetsZero
    var title: String?
    var tag: Int = 0
}
