//
//  DMActionView.swift
//  DMActionController
//
//  Created by Dominic Miller on 7/30/19.
//  Copyright © 2019 Dominic Miller (dominicmdev@gmail.com)
//

import UIKit

protocol DMActionViewDelegate: class {
    var backgroundColor: UIColor! { get }
    func actionView(_ actionView: DMActionView, wasSelectedWith action: DMAction)
}

class DMActionView: UIStackView {
    
    private(set) var action: DMAction
    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    
    var isHighlighted: Bool = false {
        didSet { updateViewAlphas() }
    }
    
    weak var delegate: DMActionViewDelegate?
    
    var color: UIColor {
        delegate?.backgroundColor ?? DMActionControllerAppearance.shared.backgroundColor
    }
    
    init(_ action: DMAction, style: DMActionController.Style, delegate: DMActionViewDelegate? = nil) {
        self.action = action
        super.init(frame: .null)
        self.delegate = delegate
        switch style {
        case .table: initAsTableCell()
        case .collection: initAsCollectionCell()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initAsTableCell() {
        commonInit()
        self.axis = .horizontal
        self.spacing = 8
        
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16).isActive = true
        self.heightAnchor.constraint(equalToConstant: 56).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        imageView.backgroundColor = color
        
        titleLabel.textAlignment = .natural
        titleLabel.numberOfLines = 1
        
        addArrangedSubview(imageView)
        addArrangedSubview(titleLabel)
        addSeparatorView()
        imageView.isHidden = action.image == nil
    }
    
    private func addSeparatorView() {
        let view = UIView(frame: .null)
        view.backgroundColor = .dmSeperator
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func initAsCollectionCell() {
        commonInit()
        self.axis = .vertical
        self.spacing = 4
        
        let view = UIView(frame: frame)
        let imageContainer = UIView(frame: frame)
        imageContainer.addSubview(imageView)
        view.addSubview(imageContainer)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-32)/3).isActive = true
        self.heightAnchor.constraint(lessThanOrEqualToConstant: 110).isActive = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor).isActive = true
        imageContainer.layer.cornerRadius = 25
        imageContainer.layer.masksToBounds = true
        imageContainer.backgroundColor = .fill3
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        addArrangedSubview(view)
        addArrangedSubview(titleLabel)
    }
    
    private func commonInit() {
        self.alignment = .center
        self.distribution = .fill
        
        imageView = UIImageView(frame: frame)
        if let color = action.imageTint { imageView.tintColor = color }
        imageView.image = action.image
        
        titleLabel = UILabel(frame: frame)
        titleLabel.attributedText = action.attributedText
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        action.didUpdateIsEnabled = { [weak self] _ in
            if UIView.isInAnimationBlock {
                self?.updateViewAlphas()
            } else {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.updateViewAlphas()
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateViewAlphas()
    }
    
    private func updateViewAlphas() {
        if action.isEnabled {
            if isHighlighted {
                imageView.alpha = 0.6
                titleLabel.alpha = 0.6
            } else {
                imageView.alpha = 1
                titleLabel.alpha = 1
            }
        } else {
            imageView.alpha = 0.4
            titleLabel.alpha = 0.4
        }
    }
    
    @objc func didTap() {
        guard action.isEnabled else { return }
        delegate?.actionView(self, wasSelectedWith: action)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let position = touch.location(in: self)
        if self.bounds.contains(position) {
            isHighlighted = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return (isHighlighted = false) }
        let position = touch.location(in: self)
        if !self.bounds.contains(position) {
            isHighlighted = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isHighlighted = false
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isHighlighted = false
    }
    
}
