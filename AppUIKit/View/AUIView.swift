//
//  AUIView.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa
import IUExtensions

open class AUIView: NSView {
    /*
     -tintColor always returns a color. The color returned is the first non-default value in the receiver's superview chain (starting with itself).
     If no non-default value is found, a system-defined color is returned.
     If this view's -tintAdjustmentMode returns Dimmed, then the color that is returned for -tintColor will automatically be dimmed.
     If your view subclass uses tintColor in its rendering, override -tintColorDidChange in order to refresh the rendering if the color changes.
     */
    public var tintColor: NSColor! = NSColor.defaultTint
    
    public var backgroundColor = NSColor.white {
        didSet {
            needsDisplay = true
        }
    }
    
    @IBInspectable var backgroundColorCSS: String {
        get {
            return backgroundColor.css
        }
        set {
            backgroundColor = Color(hexString: newValue)
        }
    }
    
    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        wantsLayer = false
        layerContentsRedrawPolicy = .onSetNeedsDisplay
    }
    
    open override var wantsUpdateLayer: Bool {
        return wantsLayer
    }

    override open func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        if let context = NSGraphicsContext.current?.cgContext {
            context.setFillColor(backgroundColor.cgColor)
            context.fill(dirtyRect)
        }
    }
    
    open override func updateLayer() {
        guard let layer = layer else {
            return
        }
        
        layer.backgroundColor = backgroundColor.cgColor
    }
    
}
