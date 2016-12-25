//
//  AUIBarButtonItem.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

enum AUIBarButtonSystemItem: Int {
    case done
    case cancel
    case edit
    case save
    case add
    case flexibleSpace
    case fixedSpace
    case compose
    case reply
    case action
    case organize
    case bookmarks
    case search
    case refresh
    case stop
    case camera
    case trash
    case play
    case pause
    case rewind
    case fastForward
    case undo
    case redo
    case pageCurl
}

enum AUIBarButtonItemStyle: Int {
    case plain
    case done
}

open class AUIBarButtonItem: AUIBarItem {
    convenience init(barButtonSystemItem systemItem: AUIBarButtonSystemItem, target: Any?, action: Selector?) {
        self.init()
    }
    convenience init(customView: NSView) {
        self.init()
    }
    convenience init(image: NSImage?, style: AUIBarButtonItemStyle, target: Any?, action: Selector?) {
        self.init()
    }
    convenience init(title: String?, style: AUIBarButtonItemStyle, target: Any?, action: Selector?) {
        self.init()
    }
    convenience init(image: NSImage?, landscapeImagePhone: NSImage?, style: AUIBarButtonItemStyle, target: Any?, action: Selector?) {
        self.init()
    }
    
    weak var target: AnyObject?
    var action: Selector?
    var style: AUIBarButtonItemStyle = .plain
    var possibleTitles: Set<String>?
    var width: CGFloat = 0
    var customView: NSView?
    
    var tintColor: NSColor?
}
