//
//  DMActionControllerAppearance.swift
//  DMActionController
//
//  Created by Dominic Miller on 11/3/19.
//  Copyright © 2019 App-Order. All rights reserved.
//

import UIKit

/// An object that describes the appearance of a DMActionController.
public class DMActionControllerAppearance {
    
    internal static let shared = DMActionControllerAppearance()
    
    // MARK: - NavBar
    private let __titleTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 13),
        .foregroundColor: UIColor.black
    ]
    
    private let __messageTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 15, weight: .medium),
        .foregroundColor: UIColor.black
    ]
    
    private var _titleTextAttributes: [NSAttributedString.Key : Any]? = nil
    private var _messageTextAttributes: [NSAttributedString.Key : Any]? = nil
    
    public var titleTextAttributes: [NSAttributedString.Key : Any] {
        get { _titleTextAttributes ?? __titleTextAttributes }
        set { _titleTextAttributes = newValue }
    }
    
    public var messageTextAttributes: [NSAttributedString.Key : Any] {
        get { _messageTextAttributes ?? __messageTextAttributes }
        set { _messageTextAttributes = newValue }
    }
    
    
    // MARK: - Content Color
    
    private var _backgroundColor: UIColor? = .white
    
    /// The background color of the content
    public var backgroundColor: UIColor! {
        get { _backgroundColor ?? .white }
        set { _backgroundColor = newValue }
    }
    
    private var _cornerRadius: CGFloat? = 10 {
        didSet {
            if let radius = _cornerRadius, radius < 0 {
                _cornerRadius = 0
            }
        }
    }
    
    /// The corner radius of the content.
    /// If set to `0` or below, the content will not clip to its bounds.
    public var cornerRadius: CGFloat! {
        get { _cornerRadius ?? 10 }
        set { _cornerRadius = newValue }
    }
    
    private var __dragViewColor: UIColor = UIColor(white: 0.85, alpha: 0.8)
    private var _dragViewColor: UIColor? = nil
    
    /// The color of the drag view above the content
    public var dragViewColor: UIColor! {
        get { _dragViewColor ?? __dragViewColor }
        set { _dragViewColor = newValue }
    }
    
    private var _dragViewWidth: CGFloat? = 40
    
    /// The width of the drag view above the content
    public var dragViewWidth: CGFloat! {
        get { _dragViewWidth ?? 40 }
        set { _dragViewWidth = newValue }
    }
    
    private var _dragViewCornerRadius: CGFloat? = 3 {
        didSet {
            if let radius = _dragViewCornerRadius, radius < 0 {
                _dragViewCornerRadius = 0
            }
        }
    }
    
    /// The corner radius of the drag view above the content.
    /// If set to `0` or below, the dragView will not clip to its bounds.
    public var dragViewCornerRadius: CGFloat! {
        get { _dragViewCornerRadius ?? 3 }
        set { _dragViewCornerRadius = newValue }
    }
    
    // MARK: - Actions
    
    private let _defaultActionTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 13),
        .foregroundColor: UIColor.black
    ]
    
    private let _cancelActionTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 15, weight: .medium),
        .foregroundColor: UIColor.black
    ]
    
    private var defaultActionTextAttributes: [NSAttributedString.Key : Any]? = nil
    private var cancelActionTextAttributes: [NSAttributedString.Key : Any]? = nil
    
    public func setActionTextAttributes(_ attributes: [NSAttributedString.Key : Any]?,
                                        forStyle style: DMAction.Style) {
        switch style {
        case .default: defaultActionTextAttributes = attributes
        case .cancel: cancelActionTextAttributes = attributes
        }
    }
    
    public func actionTextAttributes(forStyle style: DMAction.Style) -> [NSAttributedString.Key : Any] {
        switch style {
        case .default: return defaultActionTextAttributes ?? _defaultActionTextAttributes
        case .cancel: return cancelActionTextAttributes ?? _cancelActionTextAttributes
        }
    }
    
    private var defaultActionImageTint: UIColor? = nil
    private var cancelActionImageTint: UIColor? = nil
    
    public func setActionImageTint(_ color: UIColor?, forStyle style: DMAction.Style) {
        switch style {
        case .default: defaultActionImageTint = color
        case .cancel: cancelActionImageTint = color
        }
    }
    
    public func actionImageTint(forStyle style: DMAction.Style) -> UIColor? {
        switch style {
        case .default: return defaultActionImageTint
        case .cancel: return cancelActionImageTint
        }
    }
    
}
