//
//  AUITabBarSegmentedControl.swift
//  AppUIKit
//
//  Created by Jaeyoung Choi on 2017. 3. 19..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Cocoa

public class AUITabBarSegmentedControl: AUISegmentedControl {

    init(items: [Item]) {
        let font = NSFont.systemFont(ofSize: 10)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        super.init(items: items,
                   selectIndicatorType: .none,
                   normalAttributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle],
                   selectedAttributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle])
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
