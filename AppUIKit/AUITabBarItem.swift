//
//  AUITabBarItem.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2017. 1. 18..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Cocoa

public enum AUITabBarSystemItem : Int, CustomStringConvertible {
    case more
    case favorites
    case featured
    case topRated
    case recents
    case contacts
    case history
    case bookmarks
    case search
    case downloads
    case mostRecent
    case mostViewed
    
    var title: String {
        switch self {
        case .more: return "More"
        case .favorites: return "Favorites"
        case .featured: return "Featured"
        case .topRated: return "Top Rated"
        case .recents: return "Recents"
        case .contacts: return "Contacts"
        case .history: return "History"
        case .bookmarks: return "Bookmarks"
        case .search: return "Search"
        case .downloads: return "Downloads"
        case .mostRecent: return "Most Recent"
        case .mostViewed: return "Most Viewed"
        }
    }
    
    public var description: String {
        return title
    }
    
    var image: NSImage! {
        switch self {
        case .more: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarMoreTemplate")
        case .favorites: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarFavoritesTemplate")
        case .featured: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarFavoritesTemplate")
        case .topRated: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarFavoritesTemplate")
        case .recents: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarHistoryTemplate")
        case .contacts: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarContactsTemplate")
        case .history: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarHistoryTemplate")
        case .bookmarks: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarBookmarksTemplate")
        case .search: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarSearchTemplate")
        case .downloads: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarDownloadsTemplate")
        case .mostRecent: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarHistoryTemplate")
        case .mostViewed: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarMostViewedTemplate")
        }
    }
    
    var selectedImage: NSImage! {
        switch self {
        case .more: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarMoreTemplateSelected")
        case .favorites: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarFavoritesTemplateSelected")
        case .featured: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarFavoritesTemplateSelected")
        case .topRated: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarFavoritesTemplateSelected")
        case .recents: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarHistoryTemplateSelected")
        case .contacts: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarContactsTemplateSelected")
        case .history: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarHistoryTemplateSelected")
        case .bookmarks: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarBookmarksTemplateSelected")
        case .search: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarSearchTemplateSelected")
        case .downloads: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarDownloadsTemplateSelected")
        case .mostRecent: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarHistoryTemplateSelected")
        case .mostViewed: return Bundle(for: AUITabBarItem.self).image(forResource: "UITabBarMostViewedTemplateSelected")
        }
    }
    
}

open class AUITabBarItem: AUIBarItem {
    public override init() {
        super.init()
    }
    
    /* The unselected image is autogenerated from the image argument. The selected image
     is autogenerated from the selectedImage if provided and the image argument otherwise.
     To prevent system coloring, provide images with UIImageRenderingModeAlwaysOriginal (see UIImage.h)
     */
    public convenience init(title: String?, image: NSImage?, tag: Int) {
        self.init()
        self.title = title
        self.image = image
        self.tag = tag
    }
    
    public convenience init(title: String?, image: NSImage?, selectedImage: NSImage?) {
        self.init()
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
    }
    
    public convenience init(tabBarSystemItem systemItem: AUITabBarSystemItem, tag: Int) {
        self.init()
        self.title = systemItem.title
        self.image = systemItem.image
        self.selectedImage = systemItem.selectedImage
        self.tag = tag
    }
    
    fileprivate var _selectedImage: NSImage?
    open var selectedImage: NSImage? {
        set {
            _selectedImage = newValue
        }
        get {
            return _selectedImage ?? image
        }
    }
    open var badgeValue: String? // default is nil
    
    
    /* To set item label text attributes use the appearance selectors available on the superclass, UIBarItem.
     
     Use the following to tweak the relative position of the label within the tab button (for handling visual centering corrections if needed because of custom text attributes)
     */
    open var titlePositionAdjustment: AUIOffset = .zero
    
    
    /// If this item displays a badge, this color will be used for the badge's background. If set to nil, the default background color will be used instead.
    @NSCopying open var badgeColor: NSColor?
    
    fileprivate var _badgeTextAttributes = [AUIControlState: [String: Any]]()
    /// Provide text attributes to use to draw the badge text for the given singular control state (Normal, Disabled, Focused, Selected, or Highlighted). Default values will be supplied for keys that are not provided by this dictionary. See NSAttributedString.h for details on what keys are available.
    open func setBadgeTextAttributes(_ textAttributes: [String : Any]?, for state: AUIControlState) {
        if state == .default {
            _badgeTextAttributes[.default] = textAttributes
        }
        
        for controlState in AUIControlState.notDefaultStates {
            if state.contains(controlState) {
                _badgeTextAttributes[controlState] = textAttributes
            }
        }
    }
    
    
    /// Returns attributes previously set via -setBadgeTextAttributes:forState:.
    open func badgeTextAttributes(for state: AUIControlState) -> [String : Any]? {
        return _badgeTextAttributes[state] ?? _badgeTextAttributes[.default]
    }
}

