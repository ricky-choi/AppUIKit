//
//  LayoutExtension.swift
//  ACD
//
//  Created by Jaeyoung Choi on 2015. 10. 14..
//  Copyright © 2015년 Appcid. All rights reserved.
//

#if os(iOS) || os(watchOS)
    import UIKit
    public typealias View = UIView
    public typealias LayoutPriority = UILayoutPriority
    public let LayoutPriorityRequired: LayoutPriority = UILayoutPriority.required
    public let LayoutPriorityDefaultHigh: LayoutPriority = UILayoutPriority.defaultHigh
    public let LayoutPriorityDefaultLow: LayoutPriority = UILayoutPriority.defaultLow
#elseif os(OSX)
    import AppKit
    public typealias View = NSView
    public typealias LayoutPriority = NSLayoutConstraint.Priority
    public let LayoutPriorityRequired: LayoutPriority = NSLayoutConstraint.Priority.required
    public let LayoutPriorityDefaultHigh: LayoutPriority = NSLayoutConstraint.Priority.defaultHigh
    public let LayoutPriorityDefaultLow: LayoutPriority = NSLayoutConstraint.Priority.defaultLow
#endif



public struct ACDMargin {
    var leading, top, trailing, bottom: CGFloat
    
    public init(leading: CGFloat, top: CGFloat, trailing: CGFloat, bottom: CGFloat) {
        self.leading = leading
        self.top = top
        self.trailing = trailing
        self.bottom = bottom
    }
}

public struct ACDOffset {
    var x, y: CGFloat
    
    public init(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
    }
}

public let ACDMarginZero = ACDMargin(leading: 0, top: 0, trailing: 0, bottom: 0)
public let ACDOffsetZero = ACDOffset(x: 0, y: 0)

public typealias CenterConstraints = (xConstraint: NSLayoutConstraint, yConstraint: NSLayoutConstraint)
public typealias MarginConstraints = (leadingConstraint: NSLayoutConstraint, topConstraint: NSLayoutConstraint, trailingConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint)

extension View {
    public func fillXToSuperview() {
        assert(superview != nil)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": self])
        NSLayoutConstraint.activate(horizontalConstraints)
    }
    
    public func fillYToSuperview() {
        assert(superview != nil)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": self])
        NSLayoutConstraint.activate(verticalConstraints)
    }
    
    @discardableResult
    public func fillToSuperview(_ margin: ACDMargin = ACDMarginZero) -> MarginConstraints {
        assert(superview != nil)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1.0, constant: margin.leading)
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1.0, constant: margin.top)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1.0, constant: margin.trailing)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1.0, constant: margin.bottom)
        
        NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint, bottomConstraint])
        
        return (leadingConstraint, topConstraint, trailingConstraint, bottomConstraint)
    }
    
#if os(iOS) || os(tvOS)
    @available(iOS 11.0, *)
    @discardableResult
    public func fillToSafeSuperview(_ margin: ACDMargin = ACDMarginZero) -> MarginConstraints {
        assert(superview != nil)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor, constant: margin.leading)
        let trailingConstraint = trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor, constant: margin.trailing)
        let topConstraint = topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor, constant: margin.top)
        let bottomConstraint = bottomAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.bottomAnchor, constant: margin.bottom)
        
        NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint, bottomConstraint])
        
        return (leadingConstraint, topConstraint, trailingConstraint, bottomConstraint)
    }
#endif
    
    public func fixSize(_ size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: size.width)
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: size.height)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
        
        self.setContentHuggingPriority(LayoutPriorityRequired, for: .horizontal)
        self.setContentHuggingPriority(LayoutPriorityRequired, for: .vertical)
    }
    
    public func fixWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width).isActive = true
        self.setContentHuggingPriority(LayoutPriorityRequired, for: .horizontal)
    }
    
    public func fixHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height).isActive = true
        self.setContentHuggingPriority(LayoutPriorityRequired, for: .vertical)
    }
    
    @discardableResult
    public func fillAndCenterToSuperview(offset: ACDOffset = ACDOffsetZero) -> CenterConstraints {
        assert(superview != nil)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        fixSize(superview!.bounds.size)
        return centerToSuperview(offset: offset)
    }
    
    @discardableResult
    public func centerToSuperview(offset: ACDOffset = ACDOffsetZero) -> CenterConstraints {
        assert(superview != nil)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let xConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1.0, constant: offset.x)
        let yConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1.0, constant: offset.y)
        NSLayoutConstraint.activate([xConstraint, yConstraint])
        
        return (xConstraint, yConstraint)
    }
    
    @discardableResult
    public func centerXToSuperview() -> NSLayoutConstraint {
        assert(superview != nil)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    public func centerYToSuperview() -> NSLayoutConstraint {
        assert(superview != nil)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        constraint.isActive = true
        
        return constraint
    }
    
    public func resistSizeChange() {
        self.setContentHuggingPriority(LayoutPriorityRequired, for: .horizontal)
        self.setContentHuggingPriority(LayoutPriorityRequired, for: .vertical)
        self.setContentCompressionResistancePriority(LayoutPriorityRequired, for: .horizontal)
        self.setContentCompressionResistancePriority(LayoutPriorityRequired, for: .vertical)
    }

#if os(iOS)
    public static func layoutHelperView(_ superview: View? = nil) -> UIView {
        let view = View()
        if let superview = superview {
            superview.addSubview(view)
        }
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isAccessibilityElement = false
        
        return view
    }
#endif
}

extension NSLayoutConstraint {
    public static func activateMarginConstraints(_ kc: MarginConstraints) {
        activate([kc.leadingConstraint, kc.topConstraint, kc.trailingConstraint, kc.bottomConstraint])
    }
}
