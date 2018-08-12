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
                   normalAttributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle],
                   selectedAttributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func buttonForItem(_ item: AUISegmentedControl.Item) -> AUIButton {
        let button = super.buttonForItem(item)
        
        button.widthAnchor.constraint(equalToConstant: 76).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return button
    }
    
}
