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
    
    var title: String {
        switch self {
        case .done: return "Done"
        case .cancel: return "Cancel"
        case .edit: return "Edit"
        case .save: return "Save"
        case .add: return "Add"
        case .flexibleSpace: return ""
        case .fixedSpace: return ""
        case .compose: return "Compose"
        case .reply: return "Reply"
        case .action: return "Action"
        case .organize: return "Organize"
        case .bookmarks: return "Bookmarks"
        case .search: return "Search"
        case .refresh: return "Refresh"
        case .stop: return "Stop"
        case .camera: return "Camera"
        case .trash: return "Trash"
        case .play: return "Play"
        case .pause: return "Pause"
        case .rewind: return "Rewind"
        case .fastForward: return "Fast Forward"
        case .undo: return "Undo"
        case .redo: return "Redo"
        case .pageCurl: return "Page Curl"
        }
    }
    
    var image: NSImage? {
        switch self {
        case .done, .cancel, .edit, .save, .undo, .redo, .flexibleSpace, .fixedSpace, .pageCurl:
            return nil
        case .add: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarNew")
        case .compose: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarCompose")
        case .reply: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarReply")
        case .action: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarAction")
        case .organize: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarOrganize")
        case .bookmarks: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarBookmarks")
        case .search: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarSearch")
        case .refresh: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarRefresh")
        case .stop: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarStop")
        case .camera: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarCamera")
        case .trash: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarTrash")
        case .play: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarPlay")
        case .pause: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarPause")
        case .rewind: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarRewind")
        case .fastForward: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarFastForward")
        }
    }
    
    var landscapeImage: NSImage? {
        switch self {
        case .done, .cancel, .edit, .save, .undo, .redo, .flexibleSpace, .fixedSpace, .pageCurl:
            return nil
        case .add: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarNewLandscape")
        case .compose: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarComposeLandscape")
        case .reply: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarReplyLandscape")
        case .action: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarActionSmall")
        case .organize: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarOrganizeLandscape")
        case .bookmarks: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarBookmarksLandscape")
        case .search: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarSearchLandscape")
        case .refresh: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarRefreshLandscape")
        case .stop: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarStopLandscape")
        case .camera: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarCameraSmall")
        case .trash: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarTrashLandscape")
        case .play: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarPlayLandscape")
        case .pause: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarPauseLandscape")
        case .rewind: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarRewindLandscape")
        case .fastForward: return Bundle(for: AUIBarButtonItem.self).image(forResource: "UIButtonBarFastForwardLandscape")
        }
    }
    
    var canAttachNavigationBar: Bool {
        switch self {
        case .done, .cancel, .edit, .save, .add, .compose, .reply, .action, .organize, .bookmarks, .search, .refresh, .stop, .camera, .trash, .play, .pause, .rewind, .fastForward, .undo, .redo:
            return true
        case .flexibleSpace, .fixedSpace, .pageCurl:
            return false
        }
    }
    
    var canAttachToolbar: Bool {
        switch self {
        case .done, .cancel, .edit, .save, .add, .compose, .reply, .action, .organize, .bookmarks, .search, .refresh, .stop, .camera, .trash, .play, .pause, .rewind, .fastForward, .undo, .redo, .flexibleSpace, .fixedSpace:
            return true
        case .pageCurl:
            return false
        }
    }
    
    var isSpace: Bool {
        switch self {
        case .flexibleSpace, .fixedSpace:
            return true
        case .done, .cancel, .edit, .save, .add, .compose, .reply, .action, .organize, .bookmarks, .search, .refresh, .stop, .camera, .trash, .play, .pause, .rewind, .fastForward, .undo, .redo, .pageCurl:
            return false
        
        }
    }
    
}

public enum AUIBarButtonItemStyle: Int {
    case plain
    case done
}

open class AUIBarButtonItem: AUIBarItem {
    convenience public init(barButtonSystemItem systemItem: AUIBarButtonSystemItem, target: Any?, action: Selector?) {
        self.init()
        if let image = systemItem.image {
            self.image = image
        }
        if let landscapeImage = systemItem.landscapeImage {
            self.landscapeImagePhone = landscapeImage
        }
        self.title = systemItem.title
        self.target = target as AnyObject?
        self.action = action
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
