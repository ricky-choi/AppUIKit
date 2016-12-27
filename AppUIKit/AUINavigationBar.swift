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

public enum VibrantColor {
    case color(NSColor)
    case vibrantLight
    case vibrantDark
}

public enum AUIBarStyle : Int {
    case `default`
    case black
}

open class AUINavigationBar: AUIView {
    weak var delegate: AUINavigationBarDelegate?
    
    public override var tintColor: NSColor {
        didSet {
            for subview in contentView.subviews {
                if let view = subview as? AUIView {
                    view.tintColor = tintColor
                } else if let button = subview as? NSButton {
                    button.setTintColor(color: tintColor)
                }
            }
        }
    }
    
    public var barTintColor: NSColor? {
        didSet {
            invalidateBackground()
        }
    }
    
    public var barStyle: AUIBarStyle = AUIBarStyle.default {
        didSet {
            invalidateBackground()
        }
    }
    
    let contentView = AUIView()
    var barHeight: CGFloat = 44 {
        didSet {
            heightConstraint.constant = barHeight
        }
    }
    var heightConstraint: NSLayoutConstraint!
    
    private func invalidateBackground() {
        removeVisualEffectView()
        
        let background: VibrantColor
        if let barTintColor = barTintColor {
            background = VibrantColor.color(barTintColor.darkenColor)
        } else if barStyle == .black {
            background = VibrantColor.vibrantDark
        } else {
            background = VibrantColor.vibrantLight
        }
        
        switch background {
        case .color(let color):
            backgroundColor = color
            
        case .vibrantLight:
            backgroundColor = NSColor.white.withAlphaComponent(0.75)
            
            let visualEffectView = NSVisualEffectView()
            visualEffectView.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
            visualEffectView.blendingMode = .withinWindow
            addSubview(visualEffectView, positioned: .below, relativeTo: contentView)
            visualEffectView.fillToSuperview()
            
        case .vibrantDark:
            backgroundColor = NSColor.clear
            
            let visualEffectView = NSVisualEffectView()
            visualEffectView.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
            visualEffectView.blendingMode = .withinWindow
            visualEffectView.material = .ultraDark
            addSubview(visualEffectView, positioned: .below, relativeTo: contentView)
            visualEffectView.fillToSuperview()
        }
    }
    
    private func removeVisualEffectView() {
        for subview in subviews {
            if let vev = subview as? NSVisualEffectView {
                vev.removeFromSuperview()
            }
        }
    }
    
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
        let font = NSFont.systemFont(ofSize: 15)
        
        var barLeadingAnchor: NSLayoutXAxisAnchor = leadingAnchor
        var barTrailingAnchor: NSLayoutXAxisAnchor = trailingAnchor
        
        let needDrawLeftItems = (item.leftBarButtonItems?.count ?? 0) > 0
        
        // draw back item
        if let backItem = backItem, !backItem.hidesBackButton, (!needDrawLeftItems || (needDrawLeftItems && item.leftItemsSupplementBackButton)) {
            // draw back button
            let image = backIndicatorImage ?? Bundle(for: AUINavigationBar.self).image(forResource: "UINavigationBarBackIndicatorDefault")
            
            let button = NSButton(title: backItem.title ?? "", image: image!, target: self, action: #selector(back))
            button.isBordered = false
            button.font = font
            button.setTintColor(color: tintColor)
            
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
                var button: NSButton!
                if let image = item.image {
                    button = NSButton(image: image, target: item.target, action: item.action)
                } else if let title = item.title {
                    button = NSButton(title: title, target: item.target, action: item.action)
                }
                
                if button != nil {
                    button.isBordered = false
                    button.font = font
                    button.setTintColor(color: item.tintColor ?? tintColor)
                    button.setAccessibilityLabel(item.title)
                    
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
                var button: NSButton!
                if let image = item.image {
                    button = NSButton(image: image, target: item.target, action: item.action)
                } else if let title = item.title {
                    button = NSButton(title: title, target: item.target, action: item.action)
                }
                
                if button != nil {
                    button.isBordered = false
                    button.font = font
                    button.setTintColor(color: item.tintColor ?? tintColor)
                    button.setAccessibilityLabel(item.title)
                    
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
        }
    }
    
    func back() {
        delegate?.navigationBarInvokeBackButton(self)
    }
}

extension NSButton {
    func setTintColor(color: NSColor) {
        guard title.length() > 0, let buttonCell = cell as? NSButtonCell else {
            return
        }
        
        if buttonCell.imagePosition == .imageOnly || buttonCell.imagePosition == .imageOverlaps {
            return
        }
        
        let attrString = NSAttributedString(string: title, attributes: [NSFontAttributeName: font!, NSForegroundColorAttributeName: color])
        attributedTitle = attrString
    }
}
