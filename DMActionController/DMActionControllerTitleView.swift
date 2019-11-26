//
//  DMActionControllerTitleView.swift
//  DMActionController
//
//  Created by Dominic Miller on 9/2/19.
//  Copyright © 2019 Dominic Miller (dominicmdev@gmail.com)
//

import UIKit

class DMActionControllerTitleView: UIStackView {
    
    var titleLabel: DMAutoHidingLabel
    var subtitleLabel: DMAutoHidingLabel
    
    private var appearance: DMActionControllerAppearance
    
    var title: String? {
        get { return titleLabel.text }
        set {
            if let newValue = newValue {
                titleLabel.attributedText = NSAttributedString(
                    string: newValue,
                    attributes: appearance.titleTextAttributes
                )
            } else {
                titleLabel.text = newValue
            }
        }
    }
    
    var subtitle: String? {
        get { return subtitleLabel.text }
        set {
            if let newValue = newValue {
                subtitleLabel.attributedText = NSAttributedString(
                    string: newValue,
                    attributes: appearance.messageTextAttributes
                )
            } else {
                subtitleLabel.text = newValue
            }
        }
    }
    
    init(appearance: DMActionControllerAppearance) {
        self.appearance = appearance
        titleLabel = DMAutoHidingLabel(frame: .zero)
        titleLabel.backgroundColor = .clear
        subtitleLabel = DMAutoHidingLabel(frame: .zero)
        subtitleLabel.backgroundColor = .clear
        super.init(frame: .null)
        axis = .vertical
        alignment = .center
        distribution = .fillProportionally
        addArrangedSubview(titleLabel)
        addArrangedSubview(subtitleLabel)
        heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class DMAutoHidingLabel: UILabel {
    
    override var text: String? {
        didSet { isHidden = text == nil || text!.isEmpty }
    }
    
}
