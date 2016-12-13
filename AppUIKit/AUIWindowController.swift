//
//  AUIWindowController.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 2..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUIWindowController: NSWindowController {
    
    public convenience init() {
        self.init(frame: NSZeroRect)
    }
    
    public init(frame: NSRect) {
        let window = AUIWindow(contentRect: frame, backing: .buffered, defer: true)
        super.init(window: window)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override open func windowDidLoad() {
        super.windowDidLoad()

    }
    
    open override var contentViewController: NSViewController? {
        didSet {
            if let title = contentViewController?.title {
                window?.title = title
            }
        }
    }
    
    public func show() {
        guard let window = window else {
            return
        }
        window.makeKeyAndOrderFront(self)
        
        NSApp.addWindowsItem(window, title: window.title.isEmpty ? NSLocalizedString("Empty", comment: "") : window.title, filename: false)
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
