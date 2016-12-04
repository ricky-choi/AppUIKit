//
//  AUIWindowController.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 2..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUIWindowController: NSWindowController {

    override open func windowDidLoad() {
        super.windowDidLoad()

    }
    
}

extension AUIWindowController {
    public func setSize(_ size: NSSize, animated: Bool = false) {
        guard let window = window else {
            return
        }
        
        let currentOrigin = window.frame.origin
        let newFrame = CGRect(origin: currentOrigin, size: size)
        
        window.setFrame(newFrame, display: true, animate: animated)
    }
    
    public func setDeviceSize(_ deviceSize: IDeviceSize, animated: Bool = false) {
        guard let window = window else {
            return
        }
        
        let size = deviceSize.size
        
        setSize(size, animated: animated)
        
        window.minSize = size
        window.maxSize = size
    }
}
