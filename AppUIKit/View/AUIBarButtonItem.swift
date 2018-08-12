//
//  AUIBarButtonItem.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

public enum AUIBarButtonSystemItem: Int, CustomStringConvertible {
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
    
    var title: String? {
        switch self {
        case .done: return "Done"
        case .cancel: return "Cancel"
        case .edit: return "Edit"
        case .save: return "Save"
        case .undo: return "Undo"
        case .redo: return "Redo"
        default: return nil
        }
    }
    
    public var description: String {
        switch self {
        case .done: return "Done"
        case .cancel: return "Cancel"
        case .edit: return "Edit"
        case .save: return "Save"
        case .add: return "Add"
        case .flexibleSpace: return "Flexible Space"
        case .fixedSpace: return "Fixed Space"
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
        case .add: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonNew)
        case .compose: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonCompose)
        case .reply: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonReply)
        case .action: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonAction)
        case .organize: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonOrganize)
        case .bookmarks: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonBookmarks)
        case .search: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonSearch)
        case .refresh: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonRefresh)
        case .stop: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonStop)
        case .camera: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonCamera)
        case .trash: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonTrash)
        case .play: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonPlay)
        case .pause: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonPause)
        case .rewind: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonRewind)
        case .fastForward: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonFastForward)
        }
    }
    
    var landscapeImage: NSImage? {
        switch self {
        case .done, .cancel, .edit, .save, .undo, .redo, .flexibleSpace, .fixedSpace, .pageCurl:
            return nil
        case .add: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonNewLandscape)
        case .compose: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonComposeLandscape)
        case .reply: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonReplyLandscape)
        case .action: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonActionSmall)
        case .organize: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonOrganizeLandscape)
        case .bookmarks: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonBookmarksLandscape)
        case .search: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonSearchLandscape)
        case .refresh: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonRefreshLandscape)
        case .stop: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonStopLandscape)
        case .camera: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonCameraSmall)
        case .trash: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonTrashLandscape)
        case .play: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonPlayLandscape)
        case .pause: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonPauseLandscape)
        case .rewind: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonRewindLandscape)
        case .fastForward: return Bundle(for: AUIBarButtonItem.self).image(forResource: .barButtonFastForwardLandscape)
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

    convenience public init(title: String?, image: NSImage? = nil, landscapeImagePhone: NSImage? = nil, style: AUIBarButtonItemStyle = .plain, target: Any?, action: Selector?) {
        self.init()
        self.title = title
        self.image = image
        self.landscapeImagePhone = landscapeImagePhone
        self.style = style
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
    
    weak var button: AUIButton?
}

