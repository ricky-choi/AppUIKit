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

    var navigationWindowController: AUINavigationWindowController!
    @IBAction func action(_ sender: Any) {
        let viewController = AUIViewController()
        viewController.title = "My Title"
        navigationWindowController = AUINavigationWindowController(rootViewController: viewController, frame: NSMakeRect(100, 100, 600, 400))
        navigationWindowController.navigationController.navigationBar.backgroundColor = NSColor.red
        navigationWindowController.show()
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

