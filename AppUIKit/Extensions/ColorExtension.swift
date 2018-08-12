//
//  ColorExtension.swift
//  
//
//  Created by Jaeyoung Choi on 2015. 11. 13..
//  Copyright © 2015년 Appcid. All rights reserved.
//

import Foundation

#if os(iOS) || os(watchOS)
    import UIKit
    public typealias Color = UIColor
#elseif os(OSX)
    import Cocoa
    public typealias Color = NSColor
#endif

extension NSColor {
    static let defaultTint: NSColor = .blue
}


extension Color {
    public convenience init(redFF: Int, greenFF: Int, blueFF: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(redFF)/CGFloat(255), green: CGFloat(greenFF)/CGFloat(255), blue: CGFloat(blueFF)/CGFloat(255), alpha: alpha)
    }
    
    public convenience init(whiteFF: Int, alpha: CGFloat = 1.0) {
        self.init(white: CGFloat(whiteFF)/CGFloat(0xFF), alpha: alpha)
    }
    
    public convenience init(css: UInt32, alpha: CGFloat = 1.0) {
        let redComponent = Double((css & 0xFF0000) >> 16)
        let greenComponent = Double((css & 0x00FF00) >> 8)
        let blueComponent = Double(css & 0x0000FF)
        
        self.init(red: CGFloat(redComponent / 255.0), green: CGFloat(greenComponent / 255.0), blue: CGFloat(blueComponent / 255.0), alpha: alpha)
    }
    
    public convenience init(hexString: String, alpha: CGFloat? = nil) {
        var hex = hexString
        if hex.hasPrefix("#") {
            hex = String(hex[hex.index(after: hex.startIndex)...])
        }
        
        let length = hex.count
        
        var hexNumber = UInt32()
        Scanner(string: hex).scanHexInt32(&hexNumber)
        
        var a: UInt32 = 255, r: UInt32 = 255, g: UInt32 = 255, b: UInt32 = 255
        
        if length == 3 {
            (a, r, g, b) = (255, (hexNumber >> 8) * 17, (hexNumber >> 4 & 0xF) * 17, (hexNumber & 0xF) * 17)
        } else if length == 6 {
            (a, r, g, b) = (255, hexNumber >> 16, hexNumber >> 8 & 0xFF, hexNumber & 0xFF)
        } else if length == 8 {
            (a, r, g, b) = (hexNumber >> 24, hexNumber >> 16 & 0xFF, hexNumber >> 8 & 0xFF, hexNumber & 0xFF)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha ?? CGFloat(a) / 255)
    }
    
    public static func randomColor() -> Color {
        let red = Int(arc4random_uniform(256))
        let green = Int(arc4random_uniform(256))
        let blue = Int(arc4random_uniform(256))
        
        return Color(redFF: red, greenFF: green, blueFF: blue)
    }
    
    public func isBright() -> Bool {
        var brightness: CGFloat = 0
        rgbColor.getHue(nil, saturation: nil, brightness: &brightness, alpha: nil)
        
        return brightness >= 0.85
    }
    
    public var rgbColor: Color {
        var color = self
        
        #if os(OSX)
            color = self.usingColorSpaceName(NSColorSpaceName.calibratedRGB)!
        #endif
        
        return color
    }
    
    public var css: String {
        var redFloatValue: CGFloat = 0
        var greenFloatValue: CGFloat = 0
        var blueFloatValue: CGFloat = 0
        
        var redIntValue: Int = 0
        var greenIntValue: Int = 0
        var blueIntValue: Int = 0
        
        rgbColor.getRed(&redFloatValue, green: &greenFloatValue, blue: &blueFloatValue, alpha: nil)
        
        redIntValue = Int(redFloatValue * CGFloat(255.99999))
        greenIntValue = Int(greenFloatValue * CGFloat(255.99999))
        blueIntValue = Int(blueFloatValue * CGFloat(255.99999))
        
        return String(format: "%02x%02x%02x", redIntValue, greenIntValue, blueIntValue)
    }
    
    //Technical Q&A QA1808 Matching a Bar Tint Color To Your Corporate or Brand Color
    public var darkenColor: Color {
        var redFloatValue: CGFloat = 0
        var greenFloatValue: CGFloat = 0
        var blueFloatValue: CGFloat = 0
        var alphaFloatValue: CGFloat = 0
        
        rgbColor.getRed(&redFloatValue, green: &greenFloatValue, blue: &blueFloatValue, alpha: &alphaFloatValue)
        
        return Color(red: redFloatValue.darken, green: greenFloatValue.darken, blue: blueFloatValue.darken, alpha: alphaFloatValue)
    }
}

extension CGFloat {
    public var darken: CGFloat {
        let darkenValue = self - CGFloat(0.12)
        return darkenValue > 0 ? darkenValue : 0
    }
}

