//
//  AUINavigationItem.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUINavigationItem: NSObject {
    // Initializing an Item
    public init(title: String) {
        self.title = title
        super.init()
    }
    
    // Getting and Setting Properties
    public var title: String?
    
    var prompt: String?
    
    var backBarButtonItem: AUIBarButtonItem?
    
    var hidesBackButton: Bool = false
    
    func setHidesBackButton(_ hidesBackButton: Bool, animated: Bool) {
        
    }
    
    var leftItemsSupplementBackButton: Bool = false
    
    // Customizing Views
    private var _titleView: NSView?
    public var titleView: NSView? {
        get {
            if _titleView != nil {
                return _titleView
            }
            
            if title != nil {
                titleLabel.stringValue = title!
                return titleLabel
            }
            
            return nil
        }
        set {
            _titleView = newValue
        }
    }
    lazy private var titleLabel: AUILabel = {
        let label = AUILabel()
        label.font = NSFont.systemFont(ofSize: 16, weight: NSFontWeightSemibold)
        return label
    }()
    
    var leftBarButtonItems: [AUIBarButtonItem]?
    
    var leftBarButtonItem: AUIBarButtonItem?
    
    var rightBarButtonItems: [AUIBarButtonItem]?
    
    var rightBarButtonItem: AUIBarButtonItem?
    
    func setLeftBarButtonItems(_ items: [AUIBarButtonItem]?, animated: Bool) {
        
    }
    
    func setLeftBarButton(_ item: AUIBarButtonItem?, animated: Bool) {
        
    }
    
    func setRightBarButtonItems(_ items: [AUIBarButtonItem]?, animated: Bool) {
        
    }
    
    func setRightBarButton(_ item: AUIBarButtonItem?, animated: Bool) {
        
    }
}
