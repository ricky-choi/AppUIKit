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
        let item = AUIBarButtonItem(barButtonSystemItem:.done, target: self, action: #selector(printLog(sender:)))
        item.tintColor = NSColor.red
        viewController.navigationItem.rightBarButtonItems = [
            AUIBarButtonItem(barButtonSystemItem:.action, target: self, action: #selector(printLog(sender:))),
            item
        ]

        navigationWindowController = AUINavigationWindowController(rootViewController: viewController, frame: NSMakeRect(100, 100, 600, 400))
        
        let navigationBar = navigationWindowController.navigationController.navigationBar
        navigationBar.barStyle = .black
        navigationBar.tintColor = NSColor.yellow
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: NSColor.white]
        //navigationBar.barTintColor = NSColor.magenta
        
        let button = NSButton(title: "push", target: self, action: #selector(togglePush))
        viewController.view.addSubview(button)
        button.centerToSuperview()
        
        navigationWindowController.show()
        navigationWindowController.window?.center()
    }
    
    func printLog(sender: NSButton) {
        Swift.print("hahaha", sender.title )
    }
    
    func togglePush() {
        let animated = true
        if navigationWindowController.navigationController.viewControllers.count > 1 {
            navigationWindowController.navigationController.popViewController(animated: animated)
        } else {
            let viewController = AUIViewController()
            viewController.title = "ViewTitle"
            viewController.navigationItem.leftItemsSupplementBackButton = true
            viewController.navigationItem.leftBarButtonItems = [
                AUIBarButtonItem(title: "Wow", style: .plain, target: self, action: #selector(printLog(sender:))),
                AUIBarButtonItem(title: "Cool", style: .plain, target: self, action: #selector(printLog(sender:)))
            ]
            viewController.navigationItem.rightBarButtonItems = [
                AUIBarButtonItem(title: "Hello", style: .plain, target: self, action: #selector(printLog(sender:))),
                AUIBarButtonItem(title: "AUI", style: .plain, target: self, action: #selector(printLog(sender:)))
            ]
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

