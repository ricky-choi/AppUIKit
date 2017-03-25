//
//  AUIButton.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2016. 12. 27..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa
import IUExtensions

open class AUIButton: NSButton {
    public var tintColor: NSColor? {
        didSet {
            invalidateTitleLabel()
            invalidateImage()
        }
    }
    
    public var alternateTintColor: NSColor? {
        didSet {
            invalidateTitleLabel()
            invalidateImage()
        }
    }
    
    open override var title: String {
        didSet {
            invalidateTitleLabel()
        }
    }
    
    func invalidateTitleLabel() {
        guard let buttonCell = cell as? NSButtonCell else {
            return
        }
        
        if buttonCell.imagePosition == .imageOnly || buttonCell.imagePosition == .imageOverlaps {
            return
        }
        
        if let tintColor = tintColor {
            attributedTitle = attributedTitle.addingAttribute(NSForegroundColorAttributeName, value: tintColor, range: NSMakeRange(0, attributedTitle.length))
        }
        
        if let alternateTintColor = alternateTintColor {
            attributedAlternateTitle = attributedAlternateTitle.addingAttribute(NSForegroundColorAttributeName, value: alternateTintColor, range: NSMakeRange(0, attributedAlternateTitle.length))
        }
    }
    
    func invalidateImage() {
        if tintColor != nil, image != nil {
            image = image!.tintied(color: tintColor!)
        }
        
        if alternateTintColor != nil, alternateImage != nil {
            alternateImage = alternateImage!.tintied(color: alternateTintColor!)
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        isBordered = false
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
