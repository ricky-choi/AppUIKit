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
        styleMask = styleMask.union(.fullSizeContentView)
        
        titlebarAppearsTransparent = true
        
        isMovable = true
        isMovableByWindowBackground = true
    }
}

extension NSWindow {
    public func setSize(_ size: NSSize, animated: Bool = false) {
        let currentOrigin = frame.origin
        let newFrame = CGRect(origin: currentOrigin, size: size)
        
        setFrame(newFrame, display: true, animate: animated)
        
        if let zoomButton = standardWindowButton(.zoomButton) {
            zoomButton.isEnabled = false
        }
    }
    
    public func setDevice(_ device: IDevice, animated: Bool = false) {
        let size = device.size
        
        setSize(size, animated: animated)
        
        restrictSize(size)
    }
    
    public func restrictSize(_ size: NSSize) {
        minSize = size
        maxSize = size
        
        if let zoomButton = standardWindowButton(.zoomButton) {
            zoomButton.isEnabled = false
        }
    }
}
