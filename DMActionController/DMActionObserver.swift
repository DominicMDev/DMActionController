//
//  DMActionObserver.swift
//  DMActionController
//
//  Created by Dominic Miller on 9/9/19.
//  Copyright © 2019 App-Order. All rights reserved.
//

import UIKit

class DMActionObserver: NSObject {
    
    @objc var action: DMAction
    weak var actionView: DMActionView?
    
    var isEnabledObservation: NSKeyValueObservation?
    var imageTintObservation: NSKeyValueObservation?
    var textColorObservation: NSKeyValueObservation?
    
    init(_ action: DMAction, on actionView: DMActionView) {
        self.action = action
        self.actionView = actionView
        super.init()
        
        isEnabledObservation = observe(\.action.isEnabled) { object, change in
            object.actionView?.updateViewAlphas()
        }
        
        imageTintObservation = observe(\.action.imageTint) { object, change in
            object.actionView?.updateImageTint()
        }
        
        textColorObservation = observe(\.action.textColor) { object, change in
            object.actionView?.updateTextColor()
        }
    }
    
}
