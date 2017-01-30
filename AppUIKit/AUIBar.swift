//
//  AUIBar.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2017. 1. 30..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Cocoa

open class AUIBar: AUIView {
    let contentView = AUIView()
    
    open var barTintColor: NSColor? {
        didSet {
            invalidateBackground()
        }
    }

    open var barStyle: AUIBarStyle = .default {
        didSet {
            invalidateBackground()
        }
    }
    
    var backgroundEffectColor: VibrantColor {
        if let barTintColor = barTintColor {
            return VibrantColor.color(barTintColor.darkenColor)
        } else if barStyle == .black {
            return VibrantColor.vibrantDark
        } else {
            return VibrantColor.vibrantLight
        }
    }
    
    func invalidateBackground() {
        removeVisualEffectView()
        
        switch backgroundEffectColor {
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
    
    func removeVisualEffectView() {
        for subview in subviews {
            if let vev = subview as? NSVisualEffectView {
                vev.removeFromSuperview()
            }
        }
    }
}
