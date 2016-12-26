//
//  AUIBarButtonItem.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

public enum AUIBarButtonSystemItem: Int {
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

public enum AUIBarButtonItemStyle: Int {
    case plain
    case done
}

open class AUIBarButtonItem: AUIBarItem {
    convenience public init(barButtonSystemItem systemItem: AUIBarButtonSystemItem, target: Any?, action: Selector?) {
        self.init()
        
    }
    convenience public init(customView: NSView) {
        self.init()
        self.customView = customView
    }
    convenience public init(image: NSImage?, style: AUIBarButtonItemStyle, target: Any?, action: Selector?) {
        self.init()
        self.image = image
        self.style = style
        self.target = target as AnyObject?
        self.action = action
    }
    convenience public init(title: String?, style: AUIBarButtonItemStyle, target: Any?, action: Selector?) {
        self.init()
        self.title = title
        self.style = style
        self.target = target as AnyObject?
        self.action = action
    }
    convenience public init(image: NSImage?, landscapeImagePhone: NSImage?, style: AUIBarButtonItemStyle, target: Any?, action: Selector?) {
        self.init()
        self.image = image
        self.landscapeImagePhone = landscapeImagePhone
        self.target = target as AnyObject?
        self.action = action
    }
    
    public weak var target: AnyObject?
    public var action: Selector?
    public private(set) var style: AUIBarButtonItemStyle = .plain
    public var possibleTitles: Set<String>?
    public private(set) var width: CGFloat = 0
    public private(set) var customView: NSView?
    
    public var tintColor: NSColor?
}
