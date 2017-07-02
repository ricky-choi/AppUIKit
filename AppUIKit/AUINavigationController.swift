//
//  AUINavigationController.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa
import IUExtensions

@objc public protocol AUINavigationControllerDelegate: class {
    @objc optional func navigationController(_ navigationController: AUINavigationController, willShow viewController: AUIViewController, animated: Bool)
    @objc optional func navigationController(_ navigationController: AUINavigationController, didShow viewController: AUIViewController, animated: Bool)
}

open class AUINavigationController: AUIViewController {
    
    enum PushAnimation {
        case push
        case pop
        case viewControllerTransitionOptions(NSViewController.TransitionOptions)
        case none
        
        var isAnimated: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }
    }
    
    // Creating Navigation Controllers
    public init(rootViewController: AUIViewController) {
        _viewControllers = [rootViewController]
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        _viewControllers = [AUIViewController]()
        super.init(coder: coder)
    }
    
    // Accessing Items on the Navigation Stack
    public var topViewController: AUIViewController? {
        return viewControllers.last
    }
    public var visibleViewController: AUIViewController? {
        return topViewController
    }
    
    fileprivate var _viewControllers: [AUIViewController]
    public var viewControllers: [AUIViewController] {
        get {
            return _viewControllers
        }
        set {
            setViewControllers(newValue, animated: false)
        }
    }
    public func setViewControllers(_ viewControllers: [AUIViewController], animated: Bool) {
        self._viewControllers = viewControllers
        
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
        
        _viewControllers.append(viewController)
        navigationBar.pushItem(viewController.navigationItem, animated: animated)
        _navigate(fromViewController: currentViewController, toViewController: viewController, animation: animated ? .push : .none)
    }
    
    @discardableResult
    public func popViewController(animated: Bool) -> AUIViewController? {
        guard viewControllers.count > 1 else {
            return nil
        }
        
        let popedViewController = _viewControllers.removeLast()
        navigationBar.popItem(animated: animated)
        _navigate(fromViewController: popedViewController, toViewController: viewControllers.last!, animation: animated ? .pop : .none)
        
        return popedViewController
    }
    
    @discardableResult
    public func popToRootViewController(animated: Bool) -> [AUIViewController]? {
        guard viewControllers.count > 1 else {
            return nil
        }
        
        let rootViewController = viewControllers.first!
        let removeViewControllers = _viewControllers.dropFirst()
        navigationBar.setItems([rootViewController.navigationItem], animated: animated)
        _navigate(fromViewController: removeViewControllers.last!, toViewController: rootViewController, animation: animated ? .pop : .none)
        
        return Array(removeViewControllers)
    }
    
    @discardableResult
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
        _navigate(fromViewController: removeViewControllers.last!, toViewController: remainViewControllers.last!, animation: animated ? .pop : .none)
        
        return Array(removeViewControllers)
    }
    
    // Configuring Navigation Bars
    public var navigationBar: AUINavigationBar {
        get {
            if _navigationBar == nil {
                _navigationBar = AUINavigationBar()
                _navigationBar?.delegate = self
            }
            
            return _navigationBar!
        }
        set {
            _navigationBar = newValue
            _navigationBar?.delegate = self
        }
    }
    public func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        
    }
    private var _navigationBarHeight: CGFloat = 44
    private var _titleBarHeight: CGFloat = 24
    private var _navigationAreaHeight: CGFloat {
        return _navigationBarHeight + _titleBarHeight
    }
    
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
    weak open var delegate: AUINavigationControllerDelegate?
    
    // View LifeCycle
    open override func loadView() {
        view = AUIView()
        
        view.addSubview(_contentContainerView)
        _contentContainerView.fillToSuperview()
        
        view.addSubview(_navigationBarContainerView)
        _navigationBarContainerView.fillXToSuperview()
        _navigationBarContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        _navigationBarContainerView.fixHeight(_navigationAreaHeight)
        
        _navigationBarContainerView.addSubview(navigationBar);
        navigationBar.fillToSuperview()
        navigationBar.barHeight = _navigationBarHeight

        if let viewController = topViewController {
            setupInitialViewController(viewController)
        }
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
    
    fileprivate var _contentContainerView = NSView()
    fileprivate var _navigationBarContainerView = NSView()
    fileprivate var _toolbarContainerView = NSView()
    
    fileprivate var _constraintForLastViewController: MarginConstraints?
}

extension AUINavigationController {
    fileprivate func setupInitialViewController(_ viewController: AUIViewController) {
        navigationBar.setItems([viewController.navigationItem], animated: false)
        viewController.navigationController = self
        
        addChildViewController(viewController)
        _contentContainerView.addSubview(viewController.view)
        _constraintForLastViewController = viewController.view.fillToSuperview()
    }
    
    fileprivate func _navigate(fromViewController: AUIViewController, toViewController: AUIViewController, animation: PushAnimation) {
        fromViewController.navigationController = self
        toViewController.navigationController = self
        
        delegate?.navigationController?(self, willShow: toViewController, animated: animation.isAnimated)

        addChildViewController(toViewController)
        
        switch animation {
        case .push:
            let viewWidth = view.bounds.size.width
            
            _contentContainerView.addSubview(toViewController.view)
            
            let newConstraintX = toViewController.view.fillToSuperview(ACDMargin(leading: viewWidth, top: 0, trailing: viewWidth, bottom: 0))
            
            NSAnimationContext.runAnimationGroup({ (context) in
                _constraintForLastViewController?.leadingConstraint.animator().constant = -viewWidth / 3.0
                _constraintForLastViewController?.trailingConstraint.animator().constant = -viewWidth / 3.0
                newConstraintX.leadingConstraint.animator().constant = 0
                newConstraintX.trailingConstraint.animator().constant = 0
            }, completionHandler: {
                fromViewController.removeFromParentViewController()
                fromViewController.view.removeFromSuperview()
                
                self._constraintForLastViewController = newConstraintX
                
                self.delegate?.navigationController?(self, didShow: toViewController, animated: animation.isAnimated)
            })
        case .pop:
            let viewWidth = view.bounds.size.width
            
            _contentContainerView.addSubview(toViewController.view, positioned: .below, relativeTo: fromViewController.view)
            
            let newConstraintX = toViewController.view.fillToSuperview(ACDMargin(leading: -viewWidth / 3.0, top: 0, trailing: -viewWidth / 3.0, bottom: 0))
            
            NSAnimationContext.runAnimationGroup({ (context) in
                _constraintForLastViewController?.leadingConstraint.animator().constant = viewWidth
                _constraintForLastViewController?.trailingConstraint.animator().constant = viewWidth
                newConstraintX.leadingConstraint.animator().constant = 0
                newConstraintX.trailingConstraint.animator().constant = 0
            }, completionHandler: {
                fromViewController.removeFromParentViewController()
                fromViewController.view.removeFromSuperview()
                
                self._constraintForLastViewController = newConstraintX
                
                self.delegate?.navigationController?(self, didShow: toViewController, animated: animation.isAnimated)
            })
        case .viewControllerTransitionOptions(let options):
            _contentContainerView.addSubview(toViewController.view)
            _constraintForLastViewController = toViewController.view.fillToSuperview()
            
            transition(from: fromViewController, to: toViewController, options: options, completionHandler: {
                fromViewController.removeFromParentViewController()
                fromViewController.view.removeFromSuperview()
                
                self.delegate?.navigationController?(self, didShow: toViewController, animated: animation.isAnimated)
            })
        case .none:
            _contentContainerView.addSubview(toViewController.view)
            _constraintForLastViewController = toViewController.view.fillToSuperview()
            
            fromViewController.removeFromParentViewController()
            fromViewController.view.removeFromSuperview()
            
            delegate?.navigationController?(self, didShow: toViewController, animated: animation.isAnimated)
        }

    }
}

extension AUINavigationController: AUINavigationBarDelegate {
    func navigationBarInvokeBackButton(_ navigationBar: AUINavigationBar) {
        popViewController(animated: true)
    }
}

