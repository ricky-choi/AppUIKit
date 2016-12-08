//
//  AUIView.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa
import AppcidCocoaUtil

open class AUIView: NSView {
    
    var backgroundColor = NSColor.white {
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
        wantsLayer = true
        layerContentsRedrawPolicy = .onSetNeedsDisplay
    }
    
    open override var wantsUpdateLayer: Bool {
        return true
    }

    override open func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    }
    
    open override func updateLayer() {
        guard let layer = layer else {
            return
        }
        
        layer.backgroundColor = backgroundColor.cgColor
    }
    
}
