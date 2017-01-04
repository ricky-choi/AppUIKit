//
//  AUIWindowController.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 2..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUIWindowController: NSWindowController {
    
    public init(frame: NSRect) {
        let window = AUIWindow(contentRect: frame, backing: .buffered, defer: true)
        super.init(window: window)
    }
    
    public convenience init() {
        self.init(frame: NSZeroRect)
    }
    
    public convenience init(device: IDevice) {
        self.init(frame: NSZeroRect)
        setDevice(device)
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
    
    public func showAndCenter() {
        guard let window = window else {
            return
        }
        show()
        window.center()
    }
    
}

extension NSWindowController {
    public func setSize(_ size: NSSize, animated: Bool = false) {
        window?.setSize(size, animated: animated)
    }
    
    public func setDevice(_ device: IDevice, animated: Bool = false) {
        window?.setDevice(device, animated: animated)
    }
}
