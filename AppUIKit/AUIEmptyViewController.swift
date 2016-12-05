//
//  AUIEmptyViewController.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUIEmptyViewController: NSViewController {

    open override func loadView() {
        view = AUIView()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
