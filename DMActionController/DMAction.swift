//
//  DMAction.swift
//  DMActionController
//
//  Created by Dominic Miller on 7/30/19.
//  Copyright © 2019 Dominic Miller (dominicmdev@gmail.com)
//

import UIKit

extension DMAction {
    
    /// Styles to apply to action buttons in a `ZRActionController`.
    public enum Style : Int {
        
        /// Apply the default style to the action’s button.
        case `default`
        
        /// Apply a style that indicates the action cancels the operation and leaves things unchanged.
        ///
        /// Only one action with this style can be used in a `ZRActionController`.
        /// When a second action with this style is added to a `ZRActionController`,
        /// it overrides the previous action with this style.
        case cancel
    }
}

/// An action that can be taken when the user taps a button in a `DMActionController`.
///
/// You use this class to configure information about a single action,
/// including the image and title to display in the button, any styling information,
/// and a handler to execute when the user taps the button.
/// After creating an action object, add it to a `DMActionController` object
/// before displaying the corresponding alert to the user.
open class DMAction: NSObject {
    
    private var _title: String?
    private var _image: UIImage?
    private var _style: Style!
    private var _textColor: UIColor? = nil
    private var handler: ((DMAction) -> Void)?
    internal var didUpdateIsEnabled: ((Bool) -> Void)?
    
    /// Create and return an action with the specified image, title, and behavior.
    ///
    /// Actions are enabled by default when you create them.
    /// - Parameters:
    ///   - image: The image to use for the button image. This parameter must not be nil, except in an action
    ///            with `ZRAction.Style.cancel` or in an action controller view with `DMActionController.Style.table`.
    ///   - title: The text to use for the button title. This parameter must not be nil, except in an action
    ///            with `DMAction.Style.cancel`.
    ///   - style: Additional styling information to apply to the button. Use the style information to convey
    ///            the type of action that is performed by the button. For a list of possible values, see the
    ///            constants in `DMAction.Style`.
    ///   - handler: A block to execute when the user selects the action. This block has no return value and
    ///              takes the selected action object as its only parameter.
    /// - Returns: A new action object.
    public convenience init(image: UIImage? = nil, title: String?, style: Style, handler: ((DMAction) -> Void)? = nil) {
        self.init()
        self._image = image
        self._title = title
        self._style = style
        self.handler = handler
    }
    
    /// The title of the action’s button.
    ///
    /// This property is set to the value you specified in the `init(image:title:style:handler:)` method.
    open var title: String? { return _title }
    
    /// The image of the action’s button.
    ///
    /// This property is set to the value you specified in the `init(image:title:style:handler:)` method.
    open var image: UIImage? { return _image }
    
    /// The style that is applied to the action’s button.
    ///
    /// This property is set to the value you specified in the `init(image:title:style:handler:)` method.
    open var style: DMAction.Style { return _style }
    
    /// The color that is applied to title of the action’s button.
    ///
    /// The default value of this property is `UIColor.black`.
    open var textColor: UIColor! {
        get { return _textColor ?? .black }
        set { _textColor = newValue }
    }
    
    /// The color that is applied to image of the action’s button.
    ///
    /// The default value of this property is `nil`.
    open var imageTint: UIColor? = .none
    
    /// A Boolean value indicating whether the action is currently enabled.
    ///
    /// The default value of this property is true. Changing the value to false causes the action to appear dimmed
    /// in the resulting action view. When an action is disabled, taps on the corresponding button have no effect.
    open var isEnabled: Bool = true {
        didSet { didUpdateIsEnabled?(isEnabled) }
    }
    
}

internal extension DMAction {
    func performHandler() {
        handler?(self)
    }
}
