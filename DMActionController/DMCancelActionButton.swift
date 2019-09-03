//
//  DMCancelActionButton.swift
//  DMActionController
//
//  Created by Dominic Miller on 7/30/19.
//  Copyright © 2019 Dominic Miller (dominicmdev@gmail.com)
//

import UIKit

class DMCancelActionButton: UIButton {
    
    var action: DMAction? {
        didSet { update() }
    }
    
    func update() {
        if let action = action {
            isHidden = false
            setImage(action.image, for: .normal)
            if let color = action.imageTint {
                imageView?.tintColor = color
                imageView?.alpha = action.isEnabled ? 1 : 0.4
            }
            setTitle(action.title ?? "Cancel", for: .normal)
            setTitleColor(action.textColor, for: .normal)
            setTitleColor(action.textColor.withAlphaComponent(0.4), for: .disabled)
            isEnabled = action.isEnabled
        } else {
            isHidden = true
            setImage(nil, for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        update()
    }
    
}
