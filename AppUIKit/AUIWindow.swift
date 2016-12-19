//
//  AUIWindow.swift
//  AppUIKit
//
//  Created by ricky on 2016. 11. 29..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUIWindow: NSWindow {
    static let defaultStyleMask: NSWindowStyleMask = [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView]
    
    public convenience init(contentRect: NSRect, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        self.init(contentRect: contentRect, styleMask: AUIWindow.defaultStyleMask, backing: bufferingType, defer: flag)
    }
    
    override init(contentRect: NSRect, styleMask style: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)
        
        setup()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    func setup() {
        styleMask = [styleMask, .fullSizeContentView]
        
        titlebarAppearsTransparent = true
        
        isMovable = true
        isMovableByWindowBackground = true
    }
}
