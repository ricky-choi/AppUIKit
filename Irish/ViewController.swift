//
//  ViewController.swift
//  Irish
//
//  Created by ricky on 2016. 11. 29..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa
import AppUIKit
import IUExtensions

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    var windowControllers = [AUIWindowController]()
    var navigationWindowController: AUINavigationWindowController!

    func printLog(sender: NSButton) {
        Swift.print("button pressed", sender.title )
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func showTabBar(_ sender: Any) {
        let windowController = AUIWindowController(device: IDevice.iPhone5)
        windowControllers.append(windowController)
        
        let tabBarController = AUITabBarController()
        
        let vc0 = AUIViewController()
        vc0.title = "V1"
        vc0.tabBarItem = AUITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        (vc0.view as! AUIView).backgroundColor = NSColor.green
        
        let vc1 = AUIViewController()
        vc1.title = "V2"
        vc1.tabBarItem = AUITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        (vc1.view as! AUIView).backgroundColor = NSColor.yellow
        
        let vc2 = AUIViewController()
        vc2.title = "V3"
        vc2.tabBarItem = AUITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        (vc2.view as! AUIView).backgroundColor = NSColor.blue
        
        let vc3 = AUIViewController()
        vc3.title = "V4"
        vc3.tabBarItem = AUITabBarItem(tabBarSystemItem: .featured, tag: 3)
        (vc3.view as! AUIView).backgroundColor = NSColor.red
        
        tabBarController.viewControllers = [vc0, vc1, vc2, vc3]
        
        windowController.contentViewController = tabBarController
        windowController.showAndCenter()
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func showIPhone5(_ sender: Any) {
        let device = IDevice.iPhone5
        
        let windowController = AUIWindowController(device: device)
        windowControllers.append(windowController)
        
        let viewController = AUIViewController()
        viewController.title = device.description
        windowController.contentViewController = viewController
        windowController.showAndCenter()
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func showWindow(_ sender: Any) {
        let windowController = AUIWindowController()
        windowControllers.append(windowController)
        
        let viewController = AUIViewController()
        viewController.title = "My Title"
        let navigationController = AUINavigationController(rootViewController: viewController)
        navigationController.view.frame = NSMakeRect(100, 100, 600, 400)
        windowController.contentViewController = navigationController
        windowController.show()
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func showNavigationWindow(_ sender: Any) {
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
        //navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: NSColor.white]
        //navigationBar.barTintColor = NSColor.magenta
        
        let button = NSButton(title: "push", target: self, action: #selector(togglePush))
        viewController.view.addSubview(button)
        button.centerToSuperview()
        
        navigationWindowController.showAndCenter()
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
}

