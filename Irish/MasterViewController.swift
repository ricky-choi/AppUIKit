//
//  MasterViewController.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2017. 3. 25..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Cocoa
import AppUIKit
import IUExtensions

class MasterViewController: AUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Master"
        
        let button = NSButton(title: "push", target: self, action: #selector(push))
        view.addSubview(button)
        button.centerToSuperview()
    }

    @objc func push() {
        let viewController = DetailViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
