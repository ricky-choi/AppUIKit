//
//  WindowController.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 2..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa
import AppUIKit

class WindowController: AUIWindowController {
    
    var selectedSizeMenuItem: NSMenuItem?

    override func windowDidLoad() {
        super.windowDidLoad()
        
    }
    
    @IBAction func setWindowSize(_ sender: AnyObject) {
        guard let menuItem = sender as? NSMenuItem else {
            return
        }
        
        if let deviceSize = deviceSize(for: menuItem.tag) {
            setSize(deviceSize.size, animated: true)
            
            selectedSizeMenuItem?.state = NSOffState
            menuItem.state = NSOnState
            selectedSizeMenuItem = menuItem
        }
    }
    
    func deviceSize(for senderTag: Int) -> IDeviceSize? {
        if senderTag == 1 {
            return .iPhone4
        }
        
        if senderTag == 2 {
            return .iPhone5
        }
        
        if senderTag == 3 {
            return .iPhone7
        }
        
        if senderTag == 4 {
            return .iPhone7Plus
        }
        
        return nil
    }
}

extension WindowController: NSUserInterfaceValidations {
    func validateUserInterfaceItem(_ item: NSValidatedUserInterfaceItem) -> Bool {
        return deviceSize(for: item.tag) != nil
    }
}
