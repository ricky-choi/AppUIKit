//
//  AUITabBarController.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2017. 1. 18..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Cocoa


open class AUITabBarController: AUIViewController, AUITabBarDelegate {
    open var viewControllers: [AUIViewController]?
    
    // If the number of view controllers is greater than the number displayable by a tab bar, a "More" navigation controller will automatically be shown.
    // The "More" navigation controller will not be returned by -viewControllers, but it may be returned by -selectedViewController.
    open func setViewControllers(_ viewControllers: [AUIViewController]?, animated: Bool) {
        
    }
    
    
    weak open var selectedViewController: AUIViewController? // This may return the "More" navigation controller if it exists.
    
    open var selectedIndex: Int = NSNotFound
    
    fileprivate let _tabBar: AUITabBar
    open var tabBar: AUITabBar {
        return _tabBar
    } // Provided for -[UIActionSheet showFromTabBar:]. Attempting to modify the contents of the tab bar directly will throw an exception.
    
    
    weak open var delegate: AUITabBarControllerDelegate?
    
    override init() {
        _tabBar = AUITabBar()
        
        super.init()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc public protocol AUITabBarControllerDelegate : NSObjectProtocol {
    // Managing Tab Bar Selections
    @objc optional func tabBarController(_ tabBarController: AUITabBarController, shouldSelect viewController: AUIViewController) -> Bool
    @objc optional func tabBarController(_ tabBarController: AUITabBarController, didSelect viewController: AUIViewController)
}

extension AUIViewController {
    open var tabBarItem: AUITabBarItem! {
        get {
            return nil
        }
        set {
            
        }
    }// Automatically created lazily with the view controller's title if it's not set explicitly.
    open var tabBarController: AUITabBarController? {
        return nil
    } // If the view controller has a tab bar controller as its ancestor, return it. Returns nil otherwise.
}
