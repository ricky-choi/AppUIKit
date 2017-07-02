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
        
        if let device = device(for: menuItem.tag) {
            setSize(device.size, animated: true)
            
            selectedSizeMenuItem?.state = NSControl.StateValue.offState
            menuItem.state = NSControl.StateValue.onState
            selectedSizeMenuItem = menuItem
        }
    }
    
    func device(for senderTag: Int) -> IDevice? {
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
        return device(for: item.tag) != nil
    }
}
