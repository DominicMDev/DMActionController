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
    
    internal static func copy() -> DMActionControllerAppearance {
        return DMActionControllerAppearance(copy: shared)
    }
    
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
    
    internal var tintColor: UIColor {
        if let color = titleTextAttributes[.foregroundColor] as? UIColor {
            return color
        } else {
            return .black
        }
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
    
    private let __dragViewColor: UIColor = UIColor(white: 0.85, alpha: 0.8)
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
    
    // MARK: - Object Lifecycle
    
    init() {}
    
    init(copy: DMActionControllerAppearance) {
        _titleTextAttributes = copy._titleTextAttributes
        _messageTextAttributes = copy._messageTextAttributes
        _backgroundColor = copy._backgroundColor
        _cornerRadius = copy._cornerRadius
        _dragViewColor = copy._dragViewColor
        _dragViewWidth = copy._dragViewWidth
        _dragViewCornerRadius = copy._dragViewCornerRadius
    }
    
}



public class DMActionAppearance {
    
    internal static let shared = DMActionAppearance()
    
    internal static func copy() -> DMActionAppearance {
        return DMActionAppearance(copy: shared)
    }
    
    private var _backgroundColor: UIColor? = .white
    
    /// The background color of the action content.
    public var backgroundColor: UIColor! {
        get { _backgroundColor ?? .white }
        set { _backgroundColor = newValue }
    }
    
    private let _defaultTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 13),
        .foregroundColor: UIColor.black
    ]
    
    private let _cancelTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 15, weight: .medium),
        .foregroundColor: UIColor.black
    ]
    
    private var defaultTextAttributes: [NSAttributedString.Key : Any]? = nil
    private var cancelTextAttributes: [NSAttributedString.Key : Any]? = nil
    
    /// <#Description#>
    /// - Parameters:
    ///   - attributes: <#attributes description#>
    ///   - style: <#style description#>
    public func setTextAttributes(_ attributes: [NSAttributedString.Key : Any]?,
                                  forStyle style: DMAction.Style) {
        switch style {
        case .default: defaultTextAttributes = attributes
        case .cancel: cancelTextAttributes = attributes
        }
    }
    
    /// <#Description#>
    /// - Parameter style: <#style description#>
    public func textAttributes(forStyle style: DMAction.Style) -> [NSAttributedString.Key : Any] {
        switch style {
        case .default: return defaultTextAttributes ?? _defaultTextAttributes
        case .cancel: return cancelTextAttributes ?? _cancelTextAttributes
        }
    }
    
    internal func textColor(forStyle style: DMAction.Style) -> UIColor {
        let attributes = textAttributes(forStyle: style)
        if let color = attributes[.foregroundColor] as? UIColor {
            return color
        } else {
            return .black
        }
    }
    
    private var defaultImageTint: UIColor? = nil
    private var cancelImageTint: UIColor? = nil
    
    /// <#Description#>
    /// - Parameters:
    ///   - color: <#color description#>
    ///   - style: <#style description#>
    public func setImageTint(_ color: UIColor?, forStyle style: DMAction.Style) {
        switch style {
        case .default: defaultImageTint = color
        case .cancel: cancelImageTint = color
        }
    }
    
    /// <#Description#>
    /// - Parameter style: <#style description#>
    public func imageTint(forStyle style: DMAction.Style) -> UIColor? {
        switch style {
        case .default: return defaultImageTint
        case .cancel: return cancelImageTint
        }
    }
    
    init() {}
    
    init(copy: DMActionAppearance) {
        defaultTextAttributes = copy.defaultTextAttributes
        cancelTextAttributes = copy.cancelTextAttributes
        defaultImageTint = copy.defaultImageTint
        cancelImageTint = copy.cancelImageTint
    }
    
}
