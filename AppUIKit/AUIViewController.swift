//
//  AUIViewController.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUIViewController: NSViewController {
    var _tabBarItem: AUITabBarItem?
    
    public var navigationController: AUINavigationController? {
        var target: NSViewController = self
        while let parent = target.parent {
            if let navigationController = parent as? AUINavigationController {
                return navigationController
            }
            target = parent
        }
        
        return nil
    }
    lazy public private(set) var navigationItem: AUINavigationItem = {
        return AUINavigationItem(title: self.title ?? "")
    }()
    
    open override var title: String? {
        didSet {
            navigationItem.title = title
        }
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func loadView() {
        view = AUIView()
    }
    
    func setup() {
        
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
