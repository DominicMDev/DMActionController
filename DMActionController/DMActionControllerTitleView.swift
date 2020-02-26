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
    
    var titleTextAttributes: [NSAttributedString.Key : Any] { didSet { updateTitle(title) } }
    var subtitleTextAttributes: [NSAttributedString.Key : Any] { didSet { updateSubtitle(subtitle) } }
    
    var title: String? {
        get { return titleLabel.text }
        set { updateTitle(newValue) }
    }
    
    var subtitle: String? {
        get { return subtitleLabel.text }
        set { updateSubtitle(newValue) }
    }
    
    private func updateTitle(_ title: String?) {
        if let title = title {
            titleLabel.attributedText = NSAttributedString(string: title, attributes: titleTextAttributes)
        } else {
            titleLabel.text = title
        }
    }
    
    private func updateSubtitle(_ subtitle: String?) {
        if let subtitle = subtitle {
            subtitleLabel.attributedText = NSAttributedString(string: subtitle, attributes: subtitleTextAttributes)
        } else {
            subtitleLabel.text = subtitle
        }
    }
    
    init(appearance: DMActionControllerAppearance) {
        titleLabel = DMAutoHidingLabel(frame: .zero)
        titleLabel.backgroundColor = .clear
        subtitleLabel = DMAutoHidingLabel(frame: .zero)
        subtitleLabel.backgroundColor = .clear
        titleTextAttributes = appearance.titleTextAttributes
        subtitleTextAttributes = appearance.messageTextAttributes
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
