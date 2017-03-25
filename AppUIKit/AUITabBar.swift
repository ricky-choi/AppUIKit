//
//  AUITabBar.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2017. 1. 18..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Cocoa

public enum AUITabBarItemPositioning : Int {
    case automatic
    case fill
    case centered
}

open class AUITabBar: AUIBar {
    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        let shadowView = AUIView()
        shadowView.backgroundColor = NSColor.gray.withAlphaComponent(0.5)
        addSubview(shadowView)
        shadowView.fillXToSuperview()
        shadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        invalidateBackground()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate var segmentedControl: AUITabBarSegmentedControl? {
        willSet {
            if let current = segmentedControl {
                current.removeFromSuperview()
            }
        }
        didSet {
            if let newOne = segmentedControl {
                addSubview(newOne)
                newOne.fillToSuperview()
            }
        }
    }
    
    func _invalidateItems(animated: Bool = false) {
        if let tabBarItems = items, tabBarItems.count > 0 {
            segmentedControl = AUITabBarSegmentedControl(items: tabBarItems.map({ (tabBarItem) -> AUITabBarSegmentedControl.Item in
                AUISegmentedControl.Item.multi(tabBarItem.title!, tabBarItem.image!, tabBarItem.selectedImage, .imageAbove)
            }))
            
            segmentedControl!.unselectedItemTintColor = NSColor.black
            segmentedControl!.tintColor = NSColor.red
            
            segmentedControl!.target = self
            segmentedControl!.action = #selector(selectItem(sender:))
        } else {
            segmentedControl = nil
        }
    }
    
    weak open var delegate: AUITabBarDelegate? // weak reference. default is nil
    weak var internalDelegate: AUITabBarInternalDelegate?
    
    fileprivate var _items: [AUITabBarItem]?
    open var items: [AUITabBarItem]? {
        get {
            return _items
        }
        set {
            setItems(newValue, animated: false)
        }
    }// get/set visible UITabBarItems. default is nil. changes not animated. shown in order
    
    weak open var selectedItem: AUITabBarItem? // will show feedback based on mode. default is nil
    
    
    open func setItems(_ items: [AUITabBarItem]?, animated: Bool) {
        _items = items
        
        _invalidateItems(animated: animated)
    }// will fade in or out or reorder and adjust spacing
    
    /// Unselected items in this tab bar will be tinted with this color. Setting this value to nil indicates that UITabBar should use its default value instead.
    @NSCopying open var unselectedItemTintColor: NSColor?
    
    /* The background image will be tiled to fit, even if it was not created via the UIImage resizableImage methods.
     */
    open var backgroundImage: NSImage?
    
    
    /* The selection indicator image is drawn on top of the tab bar, behind the bar item icon.
     */
    open var selectionIndicatorImage: NSImage?
    
    
    /* Default is nil. When non-nil, a custom shadow image to show instead of the default shadow image. For a custom shadow to be shown, a custom background image must also be set with -setBackgroundImage: (if the default background image is used, the default shadow image will be used).
     */
    open var shadowImage: NSImage?
    
    
    /*
     Default is UITabBarItemPositioningAutomatic. The tab bar items fill horizontally
     for the iPhone user interface idiom, and are centered with a default width and
     inter-item spacing (customizable with the itemWidth and itemSpacing
     properties) for the iPad idiom. When the tab bar is owned by a UITabBarController
     further heuristics may determine the positioning for UITabBarItemPositioningAutomatic.
     Use UITabBarItemPositioningFill to force the items to fill horizontally.
     Use UITabBarItemPositioningCenter to force the items to center with a default
     width (or the itemWidth, if set).
     */
    open var itemPositioning: AUITabBarItemPositioning = .automatic
    
    
    /*
     Set the itemWidth to a positive value to be used as the width for tab bar items
     when they are positioned as a centered group (as opposed to filling the tab bar).
     Default of 0 or values less than 0 will be interpreted as a system-defined width.
     */
    open var itemWidth: CGFloat = 0
    let itemWidthDefault: CGFloat = 76
    let itemWidthMin: CGFloat = 49
    var itemWidthInternal: CGFloat {
        if itemWidth > itemWidthMin {
            return itemWidth
        }
        
        return itemWidthDefault
    }
    
    /*
     Set the itemSpacing to a positive value to be used between tab bar items
     when they are positioned as a centered group.
     Default of 0 or values less than 0 will be interpreted as a system-defined spacing.
     */
    open var itemSpacing: CGFloat = 0
    let itemSpacingDefault: CGFloat = 30
    let itemSpacingMin: CGFloat = 4
    var itemSpacingInternal: CGFloat {
        if itemSpacing > 0 {
            return itemSpacing + itemSpacingMin
        }
        
        return itemSpacingDefault + itemSpacingMin
    }
    
    let minTabBarPadding: CGFloat = 2
    var minTabBarWidth: CGFloat {
        guard let items = items, items.count > 0 else {
            return 0
        }
        
        return minTabBarWidth(itemCount: items.count)
    }
    func minTabBarWidth(itemCount: Int) -> CGFloat {
        if itemCount > 1 {
            return minTabBarPadding * CGFloat(2) + itemWidthInternal * CGFloat(itemCount) + itemSpacingInternal * CGFloat(itemCount - 1)
        } else if itemCount == 1 {
            return minTabBarPadding * CGFloat(2) + itemWidthInternal
        }
        
        return 0
    }
    
    /*
     Default is YES.
     You may force an opaque background by setting the property to NO.
     If the tab bar has a custom background image, the default is inferred from the alpha
     values of the image—YES if it has any pixel with alpha < 1.0
     If you send setTranslucent:YES to a tab bar with an opaque custom background image
     the tab bar will apply a system opacity less than 1.0 to the image.
     If you send setTranslucent:NO to a tab bar with a translucent custom background image
     the tab bar will provide an opaque background for the image using the bar's barTintColor if defined, or black
     for UIBarStyleBlack or white for UIBarStyleDefault if barTintColor is nil.
     */
    open var isTranslucent: Bool = true

    var selectedIndex: Int {
        get {
            return segmentedControl?.selectedSegment ?? NSNotFound
        }
        set {
            guard selectedIndex != newValue else {
                return
            }
            
            segmentedControl?.selectedSegment = newValue
        }
    }
}

extension AUITabBar {
    func selectItem(sender: AUITabBarSegmentedControl) {
        selectedIndex = sender.selectedSegment
        internalDelegate?.tabBar(self, didChangeIndex: selectedIndex)
    }
    
    func selectItem(_ item: AUITabBarItem?) {
        
    }
}

@objc public protocol AUITabBarDelegate : NSObjectProtocol {
    @objc optional func tabBar(_ tabBar: AUITabBar, didSelect item: AUITabBarItem) // called when a new view is selected by the user (but not programatically)
}

protocol AUITabBarInternalDelegate : NSObjectProtocol {
    func tabBar(_ tabBar: AUITabBar, didChangeIndex selectedIndex: Int)
}
