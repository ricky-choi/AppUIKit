//
//  ViewController.swift
//  Irish
//
//  Created by ricky on 2016. 11. 29..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa
import AppUIKit
import AppcidCocoaUtil

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    var navigationWindowController: AUINavigationWindowController!
    @IBAction func action(_ sender: Any) {
        let viewController = AUIViewController()
        viewController.title = "My Title"
        (viewController.view as? AUIView)?.backgroundColor = NSColor.yellow
        
        navigationWindowController = AUINavigationWindowController(rootViewController: viewController, frame: NSMakeRect(100, 100, 600, 400))
        
        let button = NSButton(title: "push", target: self, action: #selector(togglePush))
        viewController.view.addSubview(button)
        button.centerToSuperview()
        
        navigationWindowController.show()
        navigationWindowController.window?.center()
    }
    
    func togglePush() {
        let animated = true
        if navigationWindowController.navigationController.viewControllers.count > 1 {
            navigationWindowController.navigationController.popViewController(animated: animated)
        } else {
            let viewController = AUIViewController()
            (viewController.view as! AUIView).backgroundColor = NSColor.green
            navigationWindowController.navigationController.pushViewController(viewController, animated: animated)
        }
        
    }

    var windowController: AUIWindowController!
    func makeWindow1() {
        windowController = AUIWindowController()
        let viewController = AUIViewController()
        viewController.title = "My Title"
        let navigationController = AUINavigationController(rootViewController: viewController)
        navigationController.view.frame = NSMakeRect(100, 100, 600, 400)
        windowController.contentViewController = navigationController
        windowController.show()
    }
}

