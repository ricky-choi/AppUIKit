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
    public var title: String? {
        didSet {
            titleLabel.stringValue = title ?? ""
        }
    }
    
    public var prompt: String?
    
    public var backBarButtonItem: AUIBarButtonItem?
    
    public var hidesBackButton: Bool {
        get {
            return _hidesBackButton
        }
        set {
            setHidesBackButton(newValue, animated: false)
        }
    }
    
    public func setHidesBackButton(_ hidesBackButton: Bool, animated: Bool) {
        _hidesBackButton = hidesBackButton
    }
    
    public var leftItemsSupplementBackButton: Bool = false
    
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
        label.font = NSFont.systemFont(ofSize: 16, weight: NSFont.Weight.semibold)
        return label
    }()
    
    public var leftBarButtonItems: [AUIBarButtonItem]? {
        get {
            return _leftBarButtonItems
        }
        set {
            setLeftBarButtonItems(newValue, animated: false)
        }
    }
    
    public var leftBarButtonItem: AUIBarButtonItem? {
        get {
            return leftBarButtonItems?.first
        }
        set {
            if newValue != nil {
                leftBarButtonItems = [newValue!]
            } else {
                leftBarButtonItems = nil
            }
        }
    }
    
    public var rightBarButtonItems: [AUIBarButtonItem]? {
        get {
            return _rightBarButtonItems
        }
        set {
            setRightBarButtonItems(newValue, animated: false)
        }
    }
    
    public var rightBarButtonItem: AUIBarButtonItem? {
        get {
            return rightBarButtonItems?.first
        }
        set {
            if newValue != nil {
                rightBarButtonItems = [newValue!]
            } else {
                rightBarButtonItems = nil
            }
        }
    }
    
    public func setLeftBarButtonItems(_ items: [AUIBarButtonItem]?, animated: Bool) {
        _leftBarButtonItems = items
    }
    
    public func setLeftBarButton(_ item: AUIBarButtonItem?, animated: Bool) {
        setLeftBarButtonItems((item != nil) ? [item!] : nil, animated: animated)
    }
    
    public func setRightBarButtonItems(_ items: [AUIBarButtonItem]?, animated: Bool) {
        _rightBarButtonItems = items
    }
    
    public func setRightBarButton(_ item: AUIBarButtonItem?, animated: Bool) {
        setRightBarButtonItems((item != nil) ? [item!] : nil, animated: animated)
    }
    
    // private
    internal weak var navigationBar: AUINavigationBar?
    
    private var _hidesBackButton: Bool = false
    private var _leftBarButtonItems: [AUIBarButtonItem]?
    private var _rightBarButtonItems: [AUIBarButtonItem]?

}
