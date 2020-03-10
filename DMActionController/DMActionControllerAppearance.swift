//
//  DMActionControllerAppearance.swift
//  DMActionController
//
//  Created by Dominic Miller on 11/3/19.
//  Copyright © 2019 App-Order. All rights reserved.
//

import UIKit

/// An object that describes the default appearance of a `DMActionController`.
public class DMActionControllerAppearance {
    
    internal static let shared = DMActionControllerAppearance()
    
    // MARK: - NavBar
    
    private let __titleTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 17, weight: .medium),
        .foregroundColor: UIColor.firstLabel
    ]
    
    private let __messageTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.secondLabel
    ]
    
    private var _titleTextAttributes: [NSAttributedString.Key : Any]? = nil
    private var _messageTextAttributes: [NSAttributedString.Key : Any]? = nil
    
    /// Display attributes for the controller's title text.
    ///
    /// You can specify the font, text color, text shadow color, and text shadow offset for the title in the
    /// text attributes dictionary, using the text attribute keys described in `NSAttributedString.Key`.
    public var titleTextAttributes: [NSAttributedString.Key : Any] {
        get { _titleTextAttributes ?? __titleTextAttributes }
        set { _titleTextAttributes = newValue }
    }
    
    /// Display attributes for the controller's message text.
    ///
    /// You can specify the font, text color, text shadow color, and text shadow offset for the message in the
    /// text attributes dictionary, using the text attribute keys described in `NSAttributedString.Key`.
    public var messageTextAttributes: [NSAttributedString.Key : Any] {
        get { _messageTextAttributes ?? __messageTextAttributes }
        set { _messageTextAttributes = newValue }
    }
    
    internal var tintColor: UIColor {
        if let color = titleTextAttributes[.foregroundColor] as? UIColor {
            return color
        } else {
            return .iconTint
        }
    }
    
    // MARK: - Content
    
    private var _backgroundColor: UIColor? = .fill
    
    /// The background color of the content
    public var backgroundColor: UIColor! {
        get { _backgroundColor ?? .fill }
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
    
    private let __dragViewColor: UIColor = .fill2
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
    
    /// Sets the actions' text attributes for a given action style.
    ///
    /// - Parameters:
    ///   - attributes: A dictionary containing key-value pairs for text attributes.
    ///                 You can specify the font, text color, text shadow color, and text shadow offset
    ///                 using the keys listed in `NSString` `UIKit` Additions Reference.
    ///   - style: The action style for which you want to set the text attributes for.
    public func setActionTextAttributes(_ attributes: [NSAttributedString.Key : Any]?, forStyle style: DMAction.Style) {
        DMActionAppearance.shared.setTextAttributes(attributes, forStyle: style)
    }
    
    /// Returns the actions' text attributes for a given action style.
    ///
    /// The dictionary may contain key-value pairs for text attributes for the font, text color, text shadow color,
    /// and text shadow offset using the keys listed in `NSString` `UIKit` Additions Reference.
    ///
    /// - Parameter style: The action style for which you want to know the text attributes for.
    ///
    /// - Returns: The action’s text attributes for style.
    public func actionTextAttributes(forStyle style: DMAction.Style) -> [NSAttributedString.Key : Any] {
        DMActionAppearance.shared.textAttributes(forStyle: style)
    }
    
    /// Sets the actions' image tint for a given action style.
    ///
    /// - Parameters:
    ///   - color: An optional `UIColor` to set the actions' image tint to.
    ///   - style: The action style for which you want to set the image tint for.
    public func setActionImageTint(_ color: UIColor?, forStyle style: DMAction.Style) {
        DMActionAppearance.shared.setImageTint(color, forStyle: style)
    }
    
    /// Returns the actions' image tint for a given action style.
    ///
    /// - Parameter style: The action style for which you want to know the image tint for.
    ///
    /// - Returns: The actions' image tint for style.
    public func actionImageTint(forStyle style: DMAction.Style) -> UIColor? {
        DMActionAppearance.shared.imageTint(forStyle: style)
    }
    
    internal init() {}
    
}

/// An object that describes the default appearance of a `DMAction`.
public class DMActionAppearance {
    
    internal static let shared = DMActionAppearance()
    
    private let _defaultTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 15),
        .foregroundColor: UIColor.firstLabel
    ]
    
    private let _cancelTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 15, weight: .medium),
        .foregroundColor: UIColor.firstLabel
    ]
    
    private var defaultTextAttributes: [NSAttributedString.Key : Any]? = nil
    private var cancelTextAttributes: [NSAttributedString.Key : Any]? = nil
    
    /// Sets the text attributes for a given action style.
    ///
    /// - Parameters:
    ///   - attributes: A dictionary containing key-value pairs for text attributes.
    ///                 You can specify the font, text color, text shadow color, and text shadow offset
    ///                 using the keys listed in `NSString` `UIKit` Additions Reference.
    ///   - style: The action style for which you want to set the text attributes for.
    public func setTextAttributes(_ attributes: [NSAttributedString.Key : Any]?, forStyle style: DMAction.Style) {
        switch style {
        case .default: defaultTextAttributes = attributes
        case .cancel: cancelTextAttributes = attributes
        }
    }
    
    /// Returns the text attributes for a given action style.
    ///
    /// The dictionary may contain key-value pairs for text attributes for the font, text color, text shadow color,
    /// and text shadow offset using the keys listed in `NSString` `UIKit` Additions Reference.
    ///
    /// - Parameter style: The action style for which you want to know the text attributes for.
    ///
    /// - Returns: The text attributes for style.
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
            return .firstLabel
        }
    }
    
    private var defaultImageTint: UIColor? = .iconTint
    private var cancelImageTint: UIColor? = nil
    
    /// Sets the image tint for a given action style.
    ///
    /// - Parameters:
    ///   - color: An optional `UIColor` to set the image tint to.
    ///   - style: The action style for which you want to set the image tint for.
    public func setImageTint(_ color: UIColor?, forStyle style: DMAction.Style) {
        switch style {
        case .default: defaultImageTint = color
        case .cancel: cancelImageTint = color
        }
    }
    
    /// Returns the image tint for a given action style.
    ///
    /// - Parameter style: The action style for which you want to know the image tint for.
    ///
    /// - Returns: The image tint for style.
    public func imageTint(forStyle style: DMAction.Style) -> UIColor? {
        switch style {
        case .default: return defaultImageTint
        case .cancel: return cancelImageTint
        }
    }
    
}
