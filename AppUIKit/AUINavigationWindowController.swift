//
//  AUINavigationWindowController.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 13..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUINavigationWindowController: AUIWindowController {

    public let navigationController: AUINavigationController
    
    public var view: NSView {
        return navigationController.view
    }
    
    public init(rootViewController: AUIViewController, frame: NSRect) {
        navigationController = AUINavigationController(rootViewController: rootViewController)
        navigationController.view.frame = frame
        
        super.init(frame: frame)
        
        contentViewController = navigationController
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func windowDidLoad() {
        super.windowDidLoad()
    
        
    }

}
