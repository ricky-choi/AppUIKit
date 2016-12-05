//
//  AUIWindow.swift
//  AppUIKit
//
//  Created by ricky on 2016. 11. 29..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUIWindow: NSWindow {
    public convenience init(contentRect: NSRect, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        self.init(contentRect: contentRect, styleMask: .fullSizeContentView, backing: bufferingType, defer: flag)
    }
    
    override init(contentRect: NSRect, styleMask style: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    func setup() {
        styleMask = [styleMask, .fullSizeContentView]
        titlebarAppearsTransparent = true
    }
}
