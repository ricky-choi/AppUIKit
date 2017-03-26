//
//  AUISegmentedControl.swift
//  AppUIKit
//
//  Created by Jaeyoung Choi on 2017. 3. 19..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Cocoa

open class AUISegmentedControl: NSControl {
    
    open var tintColor: NSColor? {
        didSet {
            buttons.forEach {
                $0.alternateTintColor = tintColor
            }
        }
    }
    
    open var unselectedItemTintColor: NSColor? {
        didSet {
            buttons.forEach {
                $0.tintColor = unselectedItemTintColor
            }
        }
    }
    
    public enum Item {
        case title(String)
        case image(NSImage, NSImage?)
        case multi(String, NSImage, NSImage?, NSCellImagePosition?)
        
        var hasTitle: Bool {
            switch self {
            case .title(_), .multi(_):
                return true
            case .image(_):
                return false
            }
        }
    }
    
    public enum SelectIndicatorType {
        case none
        case topBar(CGFloat, NSColor)
        case underBar(CGFloat, NSColor)
    }
    
    private var buttons = [AUIButton]()
    private var stackView = NSStackView()
    
    open var selectedSegment: Int = 0 {
        didSet {
            for button in buttons {
                if selectedSegment == button.tag {
                    button.state = NSOnState
                } else {
                    button.state = NSOffState
                }
            }
            invalidateSelectIndicator()
        }
    }
    
    public let selectIndicatorType: SelectIndicatorType
    
    open func buttonForItem(_ item: Item) -> AUIButton {
        let button: AUIButton
        switch item {
        case .title(let string):
            button = AUIButton(title: string, target: self, action: #selector(buttonInvoked(sender:)))
            button.alternateTitle = string
            button.setButtonType(.radio)
        case .image(let image, let alternateImage):
            button = AUIButton(image: image, target: self, action: #selector(buttonInvoked(sender:)))
            button.alternateImage = alternateImage
            button.setButtonType(.radio)
        case .multi(let string, let image, let alternateImage, let position):
            button = AUIButton(title: string, image: image, target: self, action: #selector(buttonInvoked(sender:)))
            button.alternateTitle = string
            button.alternateImage = alternateImage
            button.setButtonType(.radio)
            if let imagePosition = position {
                button.imagePosition = imagePosition
            }
        }
        
        button.focusRingType = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    init(items: [Item], selectIndicatorType: SelectIndicatorType, normalAttributes: [String: Any]? = nil, selectedAttributes: [String: Any]? = nil) {
        assert(items.count > 0)
        
        self.selectIndicatorType = selectIndicatorType
        
        super.init(frame: NSRect.zero)
        
        for (index, item) in items.enumerated() {
            let button: AUIButton = buttonForItem(item)
            
            button.tag = index
            if selectedSegment == button.tag {
                button.state = NSOnState
            } else {
                button.state = NSOffState
            }
            
            if item.hasTitle {
                if let attributes = normalAttributes {
                    button.attributedTitle = NSAttributedString(string: button.title, attributes: attributes)
                }
                if let alternateAttributes = selectedAttributes {
                    button.attributedAlternateTitle = NSAttributedString(string: button.title, attributes: alternateAttributes)
                }
            }
            
            buttons.append(button)
        }
        
        stackView.setViews(buttons, in: .center)
        stackView.spacing = 30
        stackView.edgeInsets = EdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        addSubview(stackView)
        stackView.fillToSuperview()

    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func buttonInvoked(sender: NSButton) {
        selectedSegment = sender.tag
        if let action = action {
            NSApp.sendAction(action, to: target, from: self)
        }
    }
    
    public func invalidateSelectIndicator() {
        
    }
    
}

