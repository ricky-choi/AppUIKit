//
//  AUINavigationBar.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

protocol AUINavigationBarDelegate: class {
    func navigationBarInvokeBackButton(_ navigationBar: AUINavigationBar)
}

open class AUINavigationBar: AUIBar {
    weak var delegate: AUINavigationBarDelegate?
    
    public override var tintColor: NSColor! {
        didSet {
            guard let item = topItem else {
                return
            }
            
            item.leftBarButtonItems?.forEach({ (item) in
                if item.tintColor == nil {
                    item.button?.tintColor = tintColor
                }
            })
            
            item.rightBarButtonItems?.forEach({ (item) in
                if item.tintColor == nil {
                    item.button?.tintColor = tintColor
                }
            })

        }
    }
    
    override func invalidateBackground() {
        super.invalidateBackground()
        
        switch backgroundEffectColor {
        case .color(let color):
            if color.isBright() {
                titleTextAttributes = [NSForegroundColorAttributeName: NSColor.black]
            } else {
                titleTextAttributes = [NSForegroundColorAttributeName: NSColor.white]
            }
        case .vibrantLight:
            titleTextAttributes = [NSForegroundColorAttributeName: NSColor.black]
        case .vibrantDark:
            titleTextAttributes = [NSForegroundColorAttributeName: NSColor.white]
        }
    }
    
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
        
        let shadowView = AUIView()
        shadowView.backgroundColor = NSColor.gray.withAlphaComponent(0.5)
        addSubview(shadowView)
        shadowView.fillXToSuperview()
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        invalidateBackground()
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
    
    public var titleTextAttributes: [String : Any]? {
        didSet {
            guard let item = topItem else {
                return
            }
            
            invalidateAttributedTitleLabel(item: item)
        }
    }
    
    func invalidateAttributedTitleLabel(item: AUINavigationItem) {
        if let label = item.titleView as? AUILabel {
            label.attributedStringValue = NSAttributedString(string: label.stringValue, attributes: titleTextAttributes)
        }
    }

    open override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        /*
        if let context = NSGraphicsContext.current()?.cgContext {
            context.setFillColor(NSColor.gray.withAlphaComponent(0.5).cgColor)
            context.fill(CGRect(x: 0, y: 0, width: bounds.width, height: 1))
        }
        */
    }
    
    fileprivate var _barTitleView: NSView?
    fileprivate var _barBackButton: NSView?
    fileprivate var _leftItemButtons: [NSView]?
    fileprivate var _rightItemButtons: [NSView]?
}

extension AUINavigationBar {
    
    fileprivate func _invalidateItem(animation: AUINavigationController.PushAnimation) {
        guard let item = topItem else {
            return
        }
        
        // remove all subviews temporarily. TODO: add animation
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // set navigation bar for navigation items
        items?.forEach({ (item) in
            item.navigationBar = nil
        })
        
        item.navigationBar = self
        
        let padding: CGFloat = 10
        
        var barLeadingAnchor: NSLayoutXAxisAnchor = leadingAnchor
        var barTrailingAnchor: NSLayoutXAxisAnchor = trailingAnchor
        
        let needDrawLeftItems = (item.leftBarButtonItems?.count ?? 0) > 0
        
        // draw back item
        if let backItem = backItem, !backItem.hidesBackButton, (!needDrawLeftItems || (needDrawLeftItems && item.leftItemsSupplementBackButton)) {
            // draw back button
            let image = backIndicatorImage ?? Bundle(for: AUINavigationBar.self).image(forResource: "UINavigationBarBackIndicatorDefault")
            let backBarButtonItem = AUIBarButtonItem(title: backItem.title ?? nil, image: image!, target: self, action: #selector(back))
            
            let button = makeButton(forBarButtonItem: backBarButtonItem)!
            
            contentView.addSubview(button)
            button.centerYToSuperview()
            button.leadingAnchor.constraint(equalTo: barLeadingAnchor, constant: padding).isActive = true
            
            _barBackButton = button
            
            barLeadingAnchor = button.trailingAnchor
        } else {
            _barBackButton?.removeFromSuperview()
            
            barLeadingAnchor = leadingAnchor
        }
        
        // draw left items
        if let leftItems = item.leftBarButtonItems {
            for item in leftItems {
                if let button = makeButton(forBarButtonItem: item) {
                    contentView.addSubview(button)
                    button.centerYToSuperview()
                    button.leadingAnchor.constraint(equalTo: barLeadingAnchor, constant: padding).isActive = true
                    
                    barLeadingAnchor = button.trailingAnchor
                }
            }
        }
        
        // draw right items
        if let rightItems = item.rightBarButtonItems {
            for item in rightItems {
                if let button = makeButton(forBarButtonItem: item) {
                    contentView.addSubview(button)
                    button.centerYToSuperview()
                    button.trailingAnchor.constraint(equalTo: barTrailingAnchor, constant: -padding).isActive = true
                    
                    barTrailingAnchor = button.leadingAnchor
                }
            }
        }
        
        // draw title view
        if let currentBarTitleView = _barTitleView {
            currentBarTitleView.removeFromSuperview()
        }
        
        if let newBarTitleView = item.titleView {
            contentView.addSubview(newBarTitleView)
            _barTitleView = newBarTitleView
            newBarTitleView.centerToSuperview()
            newBarTitleView.leadingAnchor.constraint(greaterThanOrEqualTo: barLeadingAnchor, constant: padding).isActive = true
            newBarTitleView.trailingAnchor.constraint(lessThanOrEqualTo: barTrailingAnchor, constant: -padding).isActive = true
            
            invalidateAttributedTitleLabel(item: item)
        }
    }
    
    func makeButton(forBarButtonItem item: AUIBarButtonItem) -> AUIButton? {
        let tint = item.tintColor ?? tintColor
        
        var button: AUIButton?
        if let title = item.title, let image = item.image {
            button = AUIButton(title: title, image: image, target: item.target, action: item.action)
        } else if let image = item.image {
            button = AUIButton(image: image, target: item.target, action: item.action)
        } else if let title = item.title {
            button = AUIButton(title: title, target: item.target, action: item.action)
        }
        
        if let button = button {
            button.font = NSFont.systemFont(ofSize: 15)
            button.tintColor = tint
            button.setAccessibilityLabel(item.description)
        }
        
        item.button = button
        
        return button
    }
    
    func back() {
        delegate?.navigationBarInvokeBackButton(self)
    }
}

