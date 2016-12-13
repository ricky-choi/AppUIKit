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
        super.init()
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
    public fileprivate(set) var viewControllers: [AUIViewController] // TODO: use var childViewControllers: [NSViewController]
    public func setViewControllers(_ viewControllers: [AUIViewController], animated: Bool) {
        self.viewControllers = viewControllers
        
        if let currentViewController = visibleViewController {
            currentViewController.removeFromParentViewController()
            currentViewController.view.removeFromSuperview()
        }
        
        if let lastViewController = viewControllers.last {
            setupInitialViewController(lastViewController)
        }
    }
    
    // Pushing and Popping Stack Items
    public func pushViewController(_ viewController: AUIViewController, animated: Bool) {
        guard let currentViewController = visibleViewController else {
            return
        }
        
        viewControllers.append(viewController)
        navigationBar.pushItem(viewController.navigationItem, animated: animated)
        _navigate(fromViewController: currentViewController, toViewController: viewController, animated: animated, push: true)
    }
    
    public func popViewController(animated: Bool) -> AUIViewController? {
        guard viewControllers.count > 1 else {
            return nil
        }
        
        let popedViewController = viewControllers.removeLast()
        navigationBar.popItem(animated: animated)
        _navigate(fromViewController: popedViewController, toViewController: viewControllers.last!, animated: animated, push: false)
        
        return popedViewController
    }
    
    public func popToRootViewController(animated: Bool) -> [AUIViewController]? {
        guard viewControllers.count > 1 else {
            return nil
        }
        
        let rootViewController = viewControllers.first!
        let removeViewControllers = viewControllers.dropFirst()
        navigationBar.setItems([rootViewController.navigationItem], animated: animated)
        _navigate(fromViewController: removeViewControllers.last!, toViewController: rootViewController, animated: animated, push: false)
        
        return Array(removeViewControllers)
    }
    
    public func popToViewController(_ viewController: AUIViewController, animated: Bool) -> [AUIViewController]? {
        guard viewControllers.count > 1 && viewControllers.last != viewController else {
            return nil
        }
        
        guard let targetIndex = viewControllers.index(of: viewController) else {
            return nil
        }
        
        if targetIndex == 0 {
            return popToRootViewController(animated: animated)
        }
        
        let removeViewControllers = viewControllers[targetIndex + 1..<viewControllers.count]
        let remainViewControllers = viewControllers[0...targetIndex]
        let remainNavigationItems = remainViewControllers.map { $0.navigationItem }
        
        navigationBar.setItems(remainNavigationItems, animated: animated)
        _navigate(fromViewController: removeViewControllers.last!, toViewController: remainViewControllers.last!, animated: animated, push: false)
        
        return Array(removeViewControllers)
    }
    
    // Configuring Navigation Bars
    public var navigationBar: AUINavigationBar {
        get {
            if _navigationBar == nil {
                _navigationBar = AUINavigationBar()
            }
            
            return _navigationBar!
        }
        set {
            _navigationBar = newValue
        }
    }
    public func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        
    }
    public var navigationBarHeight: CGFloat = 44
    
    // Configuring Custom Toolbars
    public var toolbar: AUIToolbar {
        get {
            if _toolbar == nil {
                _toolbar = AUIToolbar()
            }
            
            return _toolbar!
        }
        set {
            _toolbar = newValue
        }
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
        _contentContainerView.fillToSuperview()
        
        view.addSubview(_navigationBarContainerView)
        _navigationBarContainerView.fillXToSuperview()
        _navigationBarContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        _navigationBarContainerView.fixHeight(navigationBarHeight)
        
        _navigationBarContainerView.addSubview(navigationBar);
        navigationBar.fillToSuperview()
        
        if let viewController = topViewController {
            setupInitialViewController(viewController)
        }
    }
    
    private func setupInitialViewController(_ viewController: AUIViewController) {
        navigationBar.setItems([viewController.navigationItem], animated: false)
        viewController.navigationController = self
        addChildViewController(viewController)
        _contentContainerView.addSubview(viewController.view)
        
        _constraintCenterXForLastViewController = viewController.view.fillAndCenterToSuperview().xConstraint
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    open override func becomeFirstResponder() -> Bool {
        return view.window?.makeFirstResponder(topViewController) ?? true
    }
    
    private var _title: String?
    open override var title: String? {
        get {
            if _title != nil {
                return _title
            }
            
            return visibleViewController?.title
        }
        set {
            _title = newValue
        }
    }
    
    // fileprivate implementation
    fileprivate var _navigationBar: AUINavigationBar?
    fileprivate var _toolbar: AUIToolbar?
    
    fileprivate var _contentContainerView = AUIView()
    fileprivate var _navigationBarContainerView = AUIView()
    fileprivate var _toolbarContainerView = AUIView()
    
    fileprivate var _constraintCenterXForLastViewController: NSLayoutConstraint?
}

extension AUINavigationController {
    fileprivate func _navigate(fromViewController: AUIViewController, toViewController: AUIViewController, animated: Bool, push: Bool) {
        fromViewController.navigationController = self
        toViewController.navigationController = self
        
        delegate?.navigationController?(self, willShow: toViewController, animated: animated)
        
        addChildViewController(toViewController)
        
        if animated {
            let viewWidth = view.bounds.size.width
            
            if push {
                // animated && push
                _contentContainerView.addSubview(toViewController.view)
                let newConstraintX = toViewController.view.fillAndCenterToSuperview(offset: ACDOffset(x: viewWidth, y: 0)).xConstraint
                if _constraintCenterXForLastViewController == nil {
                    _constraintCenterXForLastViewController = fromViewController.view.fillAndCenterToSuperview().xConstraint
                }
                
                NSAnimationContext.runAnimationGroup({ (context) in
                    _constraintCenterXForLastViewController?.animator().constant = -viewWidth / 3.0
                    newConstraintX.animator().constant = 0
                }, completionHandler: { 
                    fromViewController.removeFromParentViewController()
                    fromViewController.view.removeFromSuperview()
                    
                    self._constraintCenterXForLastViewController = newConstraintX
                    
                    self.delegate?.navigationController?(self, didShow: toViewController, animated: animated)
                })
            } else {
                // animated && pop
                _contentContainerView.addSubview(toViewController.view, positioned: .below, relativeTo: fromViewController.view)
                let newConstraintX = toViewController.view.fillAndCenterToSuperview(offset: ACDOffset(x: -viewWidth / 3.0, y: 0)).xConstraint
                if _constraintCenterXForLastViewController == nil {
                    _constraintCenterXForLastViewController = fromViewController.view.fillAndCenterToSuperview().xConstraint
                }
                
                NSAnimationContext.runAnimationGroup({ (context) in
                    _constraintCenterXForLastViewController?.animator().constant = viewWidth
                    newConstraintX.animator().constant = 0
                }, completionHandler: { 
                    fromViewController.removeFromParentViewController()
                    fromViewController.view.removeFromSuperview()
                    
                    self._constraintCenterXForLastViewController = newConstraintX
                    
                    self.delegate?.navigationController?(self, didShow: toViewController, animated: animated)
                })
            }
        } else {
            _contentContainerView.addSubview(toViewController.view)
            toViewController.view.fillToSuperview()
            
            fromViewController.removeFromParentViewController()
            fromViewController.view.removeFromSuperview()
            
            delegate?.navigationController?(self, didShow: toViewController, animated: animated)
        }
    }
}

