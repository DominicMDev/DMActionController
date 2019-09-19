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
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    override init(frame: CGRect) {
        titleLabel = DMAutoHidingLabel(frame: .zero)
        titleLabel.backgroundColor = .clear
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .white
        
        subtitleLabel = DMAutoHidingLabel(frame: .zero)
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .white
        
        super.init(frame: frame)
        axis = .vertical
        alignment = .center
        distribution = .fillProportionally
        addArrangedSubview(titleLabel)
        addArrangedSubview(subtitleLabel)
        heightAnchor.constraint(equalToConstant: 37).isActive = true
        
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21).isActive = true
        titleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15).isActive = true
        subtitleLabel.adjustsFontSizeToFitWidth = true
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
