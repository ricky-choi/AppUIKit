//
//  AUIButton.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2016. 12. 27..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa
import AppcidCocoaUtil

open class AUIButton: NSButton {
    
    public var tintColor: NSColor? {
        didSet {
            invalidateTitleLabel()
            invalidateImage()
        }
    }
    
    public func setSafeTintColor(_ color: NSColor) {
        guard tintColor == nil else {
            return
        }
        
        tintColor = color
    }
    
    open override var title: String {
        didSet {
            invalidateTitleLabel()
        }
    }
    
    func invalidateTitleLabel() {
        guard tintColor != nil, title.length() > 0, let buttonCell = cell as? NSButtonCell else {
            return
        }
        
        if buttonCell.imagePosition == .imageOnly || buttonCell.imagePosition == .imageOverlaps {
            return
        }
        
        let attrString = NSAttributedString(string: title, attributes: [NSFontAttributeName: font!, NSForegroundColorAttributeName: tintColor!])
        attributedTitle = attrString
    }
    
    func invalidateImage() {
        guard tintColor != nil, image != nil else {
            return
        }
        
        image = image!.tintied(color: tintColor!)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        isBordered = false
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
