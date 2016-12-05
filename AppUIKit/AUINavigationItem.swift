//
//  AUINavigationItem.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUINavigationItem: NSObject {
    let title: String
    
    init(title: String) {
        self.title = title
        super.init()
    }
}
