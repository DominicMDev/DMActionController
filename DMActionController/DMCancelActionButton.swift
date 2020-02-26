//
//  DMCancelActionButton.swift
//  DMActionController
//
//  Created by Dominic Miller on 7/30/19.
//  Copyright © 2019 Dominic Miller (dominicmdev@gmail.com)
//

import UIKit

class DMCancelActionButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet { updateImageAlpha() }
    }
    
    override var isEnabled: Bool {
        didSet { updateImageAlpha() }
    }
    
    var action: DMAction? {
        didSet {
            oldValue?.didUpdateIsEnabled = nil;
            update()
            guard let action = action else { return }
            action.didUpdateIsEnabled = { [weak self] _ in
                if UIView.isInAnimationBlock {
                    self?.updateIsEnabled()
                } else {
                    UIView.animate(withDuration: 0.2) { [weak self] in
                        self?.updateIsEnabled()
                    }
                }
            }
        }
    }
    
    func update() {
        if let action = action {
            isHidden = false
            setImage(action.image, for: .normal)
            if let color = action.imageTint {
                imageView?.tintColor = color
                updateImageAlpha()
            }
            setAttributedTitles(for: action)
            isEnabled = action.isEnabled
        } else {
            isHidden = true
            setImage(nil, for: .normal)
            setTitle("Cancel", for: .normal)
        }
    }
    
    private func setAttributedTitles(for action: DMAction) {
        let string = action.title ?? "Cancel"
        let textColor = action.textColor!
        var attributes = action.textAttributes
        setAttributedTitle(NSAttributedString(string: string, attributes: attributes), for: .normal)
        attributes[.foregroundColor] = textColor.withAlphaComponent(0.4)
        setAttributedTitle(NSAttributedString(string: string, attributes: attributes), for: .disabled)
        attributes[.foregroundColor] = textColor.withAlphaComponent(0.6)
        setAttributedTitle(NSAttributedString(string: string, attributes: attributes), for: .highlighted)
    }
    
    private func updateImageAlpha() {
        if isEnabled {
            if isHighlighted {
                imageView?.alpha = 0.6
            } else {
                imageView?.alpha = 1
            }
        } else {
            imageView?.alpha = 0.4
        }
    }
    
    private func updateIsEnabled() {
        self.isEnabled = action?.isEnabled ?? false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        update()
    }
    
}
