//
//  AUINavigationBar.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUINavigationBar: AUIView {
    let contentView = AUIView()
    var barHeight: CGFloat = 44 {
        didSet {
            heightConstraint.constant = barHeight
        }
    }
    var heightConstraint: NSLayoutConstraint!
    
    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        contentView.backgroundColor = NSColor.clear
        addSubview(contentView)
        contentView.fillXToSuperview()
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        heightConstraint = contentView.heightAnchor.constraint(equalToConstant: barHeight)
        heightConstraint.isActive = true
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        window?.titleVisibility = .hidden
    }
    
    public func pushItem(_ item: AUINavigationItem, animated: Bool) {
        if _items == nil {
            _items = [AUINavigationItem]()
        }
        
        _items?.append(item)
        
        _invalidateItem(animation: animated ? .push : .none)
    }
    
    @discardableResult
    public func popItem(animated: Bool) -> AUINavigationItem? {
        guard (_items?.count ?? 0) > 1 else {
            return nil
        }
        
        let popedItem = _items?.removeLast()
        
        _invalidateItem(animation: animated ? .pop : .none)
        
        return popedItem
    }
    
    public func setItems(_ items: [AUINavigationItem]?, animated: Bool) {
        _items = items
        
        _invalidateItem(animation: animated ? .viewControllerTransitionOptions(.crossfade) : .none)
    }
    
    fileprivate var _items: [AUINavigationItem]?
    public var items: [AUINavigationItem]? {
        get {
            return _items
        }
        set {
            setItems(newValue, animated: false)
        }
    }
    
    public var topItem: AUINavigationItem? {
        return _items?.last
    }
    
    public var backItem: AUINavigationItem? {
        guard (_items?.count ?? 0) > 1 else {
            return nil
        }
        return _items![_items!.count - 2]
    }
    
    public var backIndicatorImage: NSImage?
    public var isTranslucent: Bool = true

    open override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    fileprivate var _barTitleView: NSView?
    
}

extension AUINavigationBar {
    
    fileprivate func _invalidateItem(animation: AUINavigationController.PushAnimation) {
        guard let item = topItem else {
            return
        }
        
        if let currentBarTitleView = _barTitleView {
            currentBarTitleView.removeFromSuperview()
        }
        
        if let newBarTitleView = item.titleView {
            contentView.addSubview(newBarTitleView)
            _barTitleView = newBarTitleView
            newBarTitleView.centerToSuperview()
        }
    }
}
