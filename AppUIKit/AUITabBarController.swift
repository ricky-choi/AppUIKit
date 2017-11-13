//
//  AUITabBarController.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2017. 1. 18..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Cocoa


open class AUITabBarController: AUIViewController, AUITabBarDelegate {
    
    open override func loadView() {
        view = AUIView()
        
        view.addSubview(_contentContainerView)
        _contentContainerView.fillToSuperview()
        
        view.addSubview(_tabBarContainerView)
        _tabBarContainerView.fillXToSuperview()
        _tabBarContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        _tabBarContainerView.fixHeight(_tabBarHeight)
        
        _tabBarContainerView.addSubview(tabBar)
        tabBar.fillToSuperview()
        
        
    }
    
    fileprivate var _viewControllers: [AUIViewController]?    
    open var viewControllers: [AUIViewController]? {
        get {
            return _viewControllers
        }
        set {
            setViewControllers(newValue, animated: false)
        }
    }
    
    // If the number of view controllers is greater than the number displayable by a tab bar, a "More" navigation controller will automatically be shown.
    // The "More" navigation controller will not be returned by -viewControllers, but it may be returned by -selectedViewController.
    open func setViewControllers(_ viewControllers: [AUIViewController]?, animated: Bool) {
        _viewControllers = viewControllers
        
        if let newViewControllers = _viewControllers, newViewControllers.count > 0 {
            tabBar.items = newViewControllers.map { $0.tabBarItem }
            selectedViewController = newViewControllers.first!
            selectedIndex = 0
        } else {
            tabBar.items = nil
            selectedViewController = nil
            selectedIndex = NSNotFound
        }
    }

    weak open var selectedViewController: AUIViewController? {
        didSet {
            guard oldValue != selectedViewController else {
                return
            }
            
            if let oldViewController = oldValue {
                oldViewController.removeFromParentViewController()
                oldViewController.view.removeFromSuperview()
            }
            
            if let selectedViewController = selectedViewController, let vcs = viewControllers, vcs.contains(selectedViewController) {
                addChildViewController(selectedViewController)
                _contentContainerView.addSubview(selectedViewController.view)
                selectedViewController.view.fillToSuperview()
                
                selectedIndex = vcs.index(of: selectedViewController)!
            }
        }
    }// This may return the "More" navigation controller if it exists.
    
    open var selectedIndex: Int = NSNotFound {
        didSet {
            guard oldValue != selectedIndex, let vcs = viewControllers, selectedIndex < vcs.count else {
                return
            }
            
            selectedViewController = vcs[selectedIndex]
            
            tabBar.selectedIndex = selectedIndex
        }
    }
    
    fileprivate let _tabBar: AUITabBar
    open var tabBar: AUITabBar {
        return _tabBar
    } // Provided for -[UIActionSheet showFromTabBar:]. Attempting to modify the contents of the tab bar directly will throw an exception.
    
    
    weak open var delegate: AUITabBarControllerDelegate?
    
    public override init() {
        _tabBar = AUITabBar()
        
        super.init()
        
        _tabBar.internalDelegate = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var _tabBarHeight: CGFloat = 49
    
    fileprivate var _contentContainerView = NSView()
    fileprivate var _tabBarContainerView = NSView()
}

@objc public protocol AUITabBarControllerDelegate : NSObjectProtocol {
    // Managing Tab Bar Selections
    @objc optional func tabBarController(_ tabBarController: AUITabBarController, shouldSelect viewController: AUIViewController) -> Bool
    @objc optional func tabBarController(_ tabBarController: AUITabBarController, didSelect viewController: AUIViewController)
}

extension AUIViewController {
    open var tabBarItem: AUITabBarItem! {
        get {
            if _tabBarItem == nil {
                _tabBarItem = AUITabBarItem(title: title, image: nil, tag: 0)
            }
            
            return _tabBarItem
        }
        set {
            _tabBarItem = newValue
        }
    }// Automatically created lazily with the view controller's title if it's not set explicitly.
    
    open var tabBarController: AUITabBarController? {
        return nearestAncestor() as? AUITabBarController
    } // If the view controller has a tab bar controller as its ancestor, return it. Returns nil otherwise.
}

extension AUITabBarController: AUITabBarInternalDelegate {
    func tabBar(_ tabBar: AUITabBar, didChangeIndex selectedIndex: Int) {
        self.selectedIndex = selectedIndex
    }
}
