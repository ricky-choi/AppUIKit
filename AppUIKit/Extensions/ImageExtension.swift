//
//  ImageExtension.swift
//  AppcidCocoaUtil
//
//  Created by ricky on 2016. 12. 28..
//  Copyright © 2016년 Appcid. All rights reserved.
//

import AppKit

extension NSImage {
    public func tintied(color: NSColor) -> NSImage {
        guard let copy = copy() as? NSImage else { return self }
        
        copy.lockFocus()
        
        color.set()
        NSRect(origin: CGPoint(x: 0, y: 0), size: size).fill(using: .sourceAtop)
        
        copy.unlockFocus()
        
        return copy
    }
}
