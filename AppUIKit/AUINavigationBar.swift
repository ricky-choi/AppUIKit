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

open class AUINavigationBar: AUIView {
    weak var delegate: AUINavigationBarDelegate?
    
    let contentView = AUIView()
    var barHeight: CGFloat = 44 {
        didSet {
            heightConstraint.constant = barHeight
        }
    }
    var heightConstraint: NSLayoutConstraint!
    
    public var background = VibrantColor.color(NSColor.white) {
        didSet {
            removeVisualEffectView()
            
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
        contentView.addSubview(shadowView)
        shadowView.fillXToSuperview()
        shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 1).isActive = true
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
}

extension AUINavigationBar {
    
    fileprivate func _invalidateItem(animation: AUINavigationController.PushAnimation) {
        guard let item = topItem else {
            return
        }
        
        if let backItem = backItem {
            // draw back button
            let image = backIndicatorImage ?? Bundle(for: AUINavigationBar.self).image(forResource: "Back Arrow")
            
            let button = NSButton(title: backItem.title ?? "", image: image!, target: self, action: #selector(back))
            button.isBordered = false
            
            contentView.addSubview(button)
            button.centerYToSuperview()
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
            
            _barBackButton = button
        } else {
            _barBackButton?.removeFromSuperview()
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
    
    func back() {
        delegate?.navigationBarInvokeBackButton(self)
    }
}
