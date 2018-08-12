//
//  AUIButton.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2016. 12. 27..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUIButton: NSButton {
    var originalImage: NSImage?
    var originalAlternateImage: NSImage?
    
    public var tintColor: NSColor? {
        didSet {
            invalidateTitleLabel()
            invalidateImage()
        }
    }
    
    public var alternateTintColor: NSColor? {
        didSet {
            invalidateTitleLabel()
            invalidateAlternateImage()
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
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
            mutableAttributedTitle.addAttribute(.foregroundColor, value: tintColor, range: NSMakeRange(0, attributedTitle.length))
            attributedTitle = mutableAttributedTitle.copy() as! NSAttributedString
        }
        
        if let alternateTintColor = alternateTintColor {
            let mutableAttributedAlternateTitle = NSMutableAttributedString(attributedString: attributedAlternateTitle)
            mutableAttributedAlternateTitle.addAttribute(.foregroundColor, value: alternateTintColor, range: NSMakeRange(0, attributedAlternateTitle.length))
            attributedAlternateTitle = mutableAttributedAlternateTitle.copy() as! NSAttributedString
        }
    }
    
    func invalidateImages() {
        invalidateImage()
        invalidateAlternateImage()
    }
    
    func invalidateImage() {
        if image != nil {
            if originalImage == nil {
                originalImage = image
            }
            
            if tintColor != nil {
                image = originalImage!.tintied(color: tintColor!)
            } else {
                image = originalImage
            }
        }
    }
    
    func invalidateAlternateImage() {
        if alternateImage != nil {
            if originalAlternateImage == nil {
                originalAlternateImage = alternateImage
            }
            
            if alternateTintColor != nil {
                alternateImage = alternateImage!.tintied(color: alternateTintColor!)
            } else {
                alternateImage = originalAlternateImage
            }
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
