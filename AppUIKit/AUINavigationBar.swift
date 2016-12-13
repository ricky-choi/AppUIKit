//
//  AUINavigationBar.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUINavigationBar: AUIView {
    
    func pushItem(_ item: AUINavigationItem, animated: Bool) {
        
    }
    
    @discardableResult
    func popItem(animated: Bool) -> AUINavigationItem? {
        return nil
    }
    
    func setItems(_ items: [AUINavigationItem]?, animated: Bool) {
        
    }
    
    var items: [AUINavigationItem]?
    var topItem: AUINavigationItem? {
        return nil
    }
    var backItem: AUINavigationItem? {
        return nil
    }
    
    var backIndicatorImage: NSImage?
    var isTranslucent: Bool = true

    override open func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
