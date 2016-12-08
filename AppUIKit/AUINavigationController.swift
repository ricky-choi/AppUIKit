//
//  AUINavigationController.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa
import AppcidCocoaUtil

@objc protocol AUINavigationControllerDelegate: class {
    @objc optional func navigationController(_ navigationController: AUINavigationController, willShow viewController: AUIViewController, animated: Bool)
    @objc optional func navigationController(_ navigationController: AUINavigationController, didShow viewController: AUIViewController, animated: Bool)
}

open class AUINavigationController: AUIViewController {
    
    // Creating Navigation Controllers
    public init(rootViewController: AUIViewController) {
        viewControllers = [rootViewController]
        super.init(nibName: nil, bundle: nil)!
    }
    
    required public init?(coder: NSCoder) {
        viewControllers = [AUIViewController]()
        super.init(coder: coder)
    }
    
    // Accessing Items on the Navigation Stack
    public var topViewController: AUIViewController? {
        return viewControllers.last
    }
    public var visibleViewController: AUIViewController? {
        return topViewController
    }
    public private(set) var viewControllers: [AUIViewController] // TODO: use var childViewControllers: [NSViewController]
    public func setViewControllers(_ viewControllers: [AUIViewController], animated: Bool) {
        
    }
    
    // Pushing and Popping Stack Items
    public func pushViewController(_ viewController: AUIViewController, animated: Bool) {
        
    }
    public func popViewController(animated: Bool) -> AUIViewController? {
        return nil
    }
    public func popToRootViewController(animated: Bool) -> [AUIViewController]? {
        return nil
    }
    public func popToViewController(_ viewController: AUIViewController, animated: Bool) -> [AUIViewController]? {
        return nil
    }
    
    // Configuring Navigation Bars
    public var navigationBar: AUINavigationBar {
        if _navigationBar == nil {
            _navigationBar = AUINavigationBar()
        }
        
        return _navigationBar!
    }
    public func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        
    }
    public var navigationBarHeight: CGFloat = 44
    
    // Configuring Custom Toolbars
    public var toolbar: AUIToolbar {
        if _toolbar == nil {
            _toolbar = AUIToolbar()
        }
        
        return _toolbar!
    }
    public func setToolbarHidden(_ hidden: Bool, animated: Bool) {
        
    }
    public var isToolbarHidden: Bool = true
    public var toolbarHeight: CGFloat = 44
    
    // Hiding the Navigation Bar
    public var hidesBarsOnTap: Bool = false
    public var hidesBarsOnSwipe: Bool = false
    public var hidesBarsWhenVerticallyCompact: Bool = false
    public var hidesBarsWhenKeyboardAppears: Bool = false
    public var isNavigationBarHidden: Bool = false
    
    // Accessing the Delegate
    weak var delegate: AUINavigationControllerDelegate?
    
    // View LifeCycle
    open override func loadView() {
        view = AUIView()
        
        view.addSubview(_contentContainerView)
        view.addSubview(_navigationBarContainerView)
        
        _contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        _navigationBarContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        _contentContainerView.fillToSuperview()
        _navigationBarContainerView.fillXToSuperview()
        _navigationBarContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        _navigationBarContainerView.fixHeight(navigationBarHeight)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    // private implementation
    private var _navigationBar: AUINavigationBar?
    private var _toolbar: AUIToolbar?
    
    private var _contentContainerView = AUIView()
    private var _navigationBarContainerView = AUIView()
    private var _toolbarContainerView = AUIView()
}

