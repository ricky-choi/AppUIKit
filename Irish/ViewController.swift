//
//  ViewController.swift
//  Irish
//
//  Created by ricky on 2016. 11. 29..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa
import AppUIKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    var windowController: AUIWindowController!
    @IBAction func action(_ sender: Any) {
        windowController = AUIWindowController()
        let viewController = AUIViewController()
        let navigationController = AUINavigationController(rootViewController: viewController)
        navigationController.view.frame = NSMakeRect(100, 100, 600, 400)
        windowController.contentViewController = navigationController
        
        windowController.window?.makeKeyAndOrderFront(nil)
    }

}

