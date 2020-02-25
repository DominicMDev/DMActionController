//
//  DMActionController.swift
//  DMActionController
//
//  Created by Dominic Miller on 7/30/19.
//  Copyright © 2019 Dominic Miller (dominicmdev@gmail.com)
//

import UIKit

public extension DMActionController {
    
    /// Constants indicating the type of action sheet to display.
    enum Style: Int {
        
        /// A table sheet displayed in the context of the view controller that presented it.
        ///
        /// Use a table sheet to present the user with a set of alternatives for how to proceed with a given task.
        /// You should also use this style if you do not have icons for each action you will provide.
        case table
        
        /// A collection sheet displayed in the context of the view controller that presented it.
        ///
        /// Use a collection when there are too many options to display to the user for a table sheet.
        /// You should only use this style if you have icons for each action you will provide.
        case collection
    }
    
}

/// An object that displays an action sheet to the user.
///
/// Use this class to configure action sheets with actions that you want to display and from which to choose.
/// After configuring the action controller with the actions and style you want,
/// present it using the present(_:animated:completion:) method.
/// UIKit displays action sheets modally over your app's content.
///
/// In addition to displaying a title and message to a user,
/// you must associate actions with your action controller to give the user a way to respond.
/// For each action you add using the addAction(_:) method,
/// the alert controller configures a button with the action details.
/// When the user taps that action, the action controller executes the block you provided when creating the object.
/// Listing 1 shows how to configure an action sheet with a single action.
///
/// # Listing 1 Configuring and presenting an action sheet
/// ```
/// let actionSheet = DMActionController(title: "My Action Sheet", message: "This is an action sheet.", preferredStyle: .table)
/// actionSheet.addAction(DMAction(title: "Do Action", style: .default, handler: { _ in
///     NSLog("The user tapped \"Do Action\" in the action sheet.")
/// }))
/// self.present(actionSheet, animated: true, completion: nil)
/// ```
///
/// When configuring an action sheet with the `DMActionController.Style.collection` style,
/// you must also add icons to the action.
/// - Important
/// The `DMActionController` class is intended to be used as-is and does not support subclassing.
public final class DMActionController: UIViewController {
    
    public static func appearance() -> DMActionControllerAppearance {
        return .shared
    }
    
    public override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .overFullScreen }
        set { }
    }
    
    var appearance: DMActionControllerAppearance { return .shared }
    
    /*
     *  MARK: - IBOutlets
     */
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var dragView: UIView!
    @IBOutlet weak var contentView: _DMActionControllerContentView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var cancelButton: DMCancelActionButton!
    @IBOutlet var navigationBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var dragViewWidthConstraint: NSLayoutConstraint!
    
    /*
     *  MARK: - Private Instance Properties
     */
    
    private var _actions: [DMAction] = []
    
    private var cancelAction: DMAction? = nil
    
    private lazy var titleView = DMActionControllerTitleView(appearance: appearance)
    
    private var _titleTextAttributes: [NSAttributedString.Key : Any]? = nil
    private var _messageTextAttributes: [NSAttributedString.Key : Any]? = nil
    private var _backgroundColor: UIColor? = nil
    
    private var _cornerRadius: CGFloat? = nil {
        didSet {
            if let radius = _cornerRadius, radius < 0 {
                _cornerRadius = 0
            }
        }
    }
    
    private var _dragViewColor: UIColor? = nil
    private var _dragViewWidth: CGFloat? = nil
    
    private var _dragViewCornerRadius: CGFloat? = nil {
        didSet {
            if let radius = _dragViewCornerRadius, radius < 0 {
                _dragViewCornerRadius = 0
            }
        }
    }
    
    /*
     *  MARK: - Public Instance Properties
     */
    
    /// The title of the alert.
    ///
    /// The title string is displayed prominently in the action sheet.
    /// You should use this string to get the user’s attention and communicate the reason for displaying the actions.
    override public var title: String? {
        didSet {
            titleView.title = title
        }
    }
    
    /// Descriptive text that provides more details about the reason for the alert.
    ///
    /// The message string is displayed below the title string and is less prominent.
    /// Use this string to provide additional context about the actions that the user might take.
    public var message: String? {
        didSet {
            titleView.subtitle = message
        }
    }
    
    /// Specifies if tapping on the background will act as though the user tapped on the cancel button.
    /// If `true`, when the user taps on the background,
    /// the controller will be dismissed and the cancel action will occur.
    /// The default value of this property is `true`.
    public var tapBackgroundToDismiss: Bool = true
    
    /// Specifies if dragging the view downward will act as though the user tapped on the cancel button.
    /// If `true`, when the user drags the view far enough downward and releases,
    /// the controller will be dismissed and the cancel action will occur.
    /// The default value of this property is `true`.
    public var canDragToDismiss: Bool = true
    
    /// The actions that the user can take in response to the action sheet.
    /// The actions are in the order in which you added them to the action controller.
    /// This order also corresponds to the order in which they are displayed in the action sheet.
    /// The second action in the array is displayed below the first, the third is displayed below the second, and so on.
    public var actions: [DMAction] {
        var actions = _actions
        if let cancel = cancelAction {
            actions.append(cancel)
        }
        return actions
    }
    
    /// The style of the action controller.
    ///
    /// The value of this property is set to the value you specified in the init(title:message:preferredStyle:) method.
    /// This value determines how the sheet is displayed onscreen.
    public private(set) var preferredStyle: DMActionController.Style!
    
    
    /// The text attributes for the title.
    public var titleTextAttributes: [NSAttributedString.Key : Any] {
        get { _titleTextAttributes ?? appearance.titleTextAttributes }
        set { _titleTextAttributes = newValue }
    }
    
    /// The text attributes for the message.
    public var messageTextAttributes: [NSAttributedString.Key : Any] {
        get { _messageTextAttributes ?? appearance.messageTextAttributes }
        set { _messageTextAttributes = newValue }
    }
    
    private var tintColor: UIColor {
        if let color = titleTextAttributes[.foregroundColor] as? UIColor {
            return color
        } else {
            return .black
        }
    }
    
    /// The background color of the content
    public var backgroundColor: UIColor! {
        get { _backgroundColor ?? appearance.backgroundColor }
        set { _backgroundColor = newValue }
    }
    
    /// The corner radius of the content.
    /// If set to `0` or below, the content will not clip to its bounds.
    public var cornerRadius: CGFloat! {
        get { _cornerRadius ?? appearance.cornerRadius }
        set { _cornerRadius = newValue }
    }
    
    /// The color of the drag view above the content
    public var dragViewColor: UIColor! {
        get { _dragViewColor ?? appearance.dragViewColor }
        set { _dragViewColor = newValue }
    }
    
    /// The width of the drag view above the content
    public var dragViewWidth: CGFloat! {
        get { _dragViewWidth ?? appearance.dragViewWidth }
        set { _dragViewWidth = newValue }
    }
    
    /// The corner radius of the drag view above the content.
    /// If set to `0` or below, the dragView will not clip to its bounds.
    public var dragViewCornerRadius: CGFloat! {
        get { _dragViewCornerRadius ?? appearance.dragViewCornerRadius }
        set { _dragViewCornerRadius = newValue }
    }
    
    /*
     *  MARK: - Object Lifecycle
     */
    
    /// Creates and returns a view controller for displaying an possible actions to the user.
    ///
    /// After creating the action controller, configure any actions that you want the user to be able to perform
    /// by calling the addAction(_:) method one or more times.
    /// When specifying a preferred style of UIAlertController.Style.alert,
    /// you may also configure one or more text fields to display in addition to the actions.
    ///
    /// - Parameters:
    ///   - title: The title of the sheet.
    ///            Use this string to get the user’s attention and communicate the purpose for the action sheet.
    ///   - message: Descriptive text that provides additional details about the reason for the action sheet.
    ///   - preferredStyle: The style to use when presenting the action controller.
    ///                     Use this parameter to configure the action controller as a table or as a collection.
    ///
    /// - Returns: An initialized action controller object.
    public convenience init(title: String?, message: String?, preferredStyle: DMActionController.Style) {
        self.init(nibName: "DMActionController", bundle: Bundle(for: DMActionController.self))
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        self.titleView.title = title
        self.titleView.subtitle = message
        self.transitioningDelegate = self
    }
    
    /// Attaches an action object to the alert or action sheet.
    ///
    /// The order in which you add actions determines their order in the resulting action sheet.
    ///
    /// - Parameter action: The action object to display as part of the action sheet.
    ///                     Actions are displayed as cells in the action sheet.
    ///                     The action object provides the text and the action to be performed when that cell is tapped.
    public func addAction(_ action: DMAction) {
        switch action.style {
        case .default: _actions.append(action)
        case .cancel: cancelAction = action
        }
    }
    
    /*
     *  MARK: - View Lifecycle
     */
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        setUpContentView()
        setUpNavBar()
        navigationItem.titleView = titleView
    }
    
    private func setUpContentView() {
        updateContentAppearance()
        let pan = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        containerView.addGestureRecognizer(pan)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        tap.delegate = self
        view?.addGestureRecognizer(tap)
    }
    
    private func updateContentAppearance() {
        dragView.backgroundColor = dragViewColor
        dragView.layer.cornerRadius = dragViewCornerRadius
        dragViewWidthConstraint.constant = dragViewWidth
        contentView.cornerRadius = cornerRadius
        contentView.backgroundColor = backgroundColor
        whiteView.backgroundColor = backgroundColor
        cancelButton.backgroundColor = backgroundColor
    }
    
    private func setUpNavBar() {
        setUpCloseButtonItem()
        if shouldShowNavBar() {
            navigationBar.shadowImage = nil
            navigationBar.isTranslucent = false
            updateNavBarAppearance()
            navigationBar.barStyle = .default
            navigationBarHeightConstraint.constant = 44
            navigationBar.setItems([navigationItem], animated: false)
        } else {
            navigationBar.isHidden = true
            navigationBarHeightConstraint.constant = 0
        }
    }
    
    private func setUpCloseButtonItem() {
        if cancelAction == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop,
                                                               target: self,
                                                               action: #selector(didPressCancel))
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    private func shouldShowNavBar() -> Bool {
        return !title.isNilOrEmpty || !message.isNilOrEmpty || cancelAction == nil
    }
    
    private func updateNavBarAppearance() {
        navigationBar.barTintColor = backgroundColor
        navigationBar.backgroundColor = backgroundColor
        navigationBar.tintColor = tintColor
    }
    
    /*
     *  MARK: -
     */
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateContentAppearance()
        updateNavBar()
        loadViews()
    }
    
    private func updateNavBar() {
        setUpCloseButtonItem()
        if shouldShowNavBar() {
            updateNavBarAppearance()
            navigationBar.isHidden = false
            navigationBarHeightConstraint.constant = 44
        } else {
            navigationBar.isHidden = true
            navigationBarHeightConstraint.constant = 0
        }
    }
    
    private func loadViews() {
        contentStackView.subviews.forEach({ $0.removeFromSuperview() })
        cancelButton.action = cancelAction
        let views: [UIView]
        switch preferredStyle! {
        case .table: views = loadActionViews()
        case .collection: views = loadActionViewSections()
        }
        for view in views {
            contentStackView.addArrangedSubview(view)
        }
        contentStackView.layoutIfNeeded()
    }
    
    private func loadActionViews() -> [DMActionView] {
        return _actions.map({ DMActionView($0, style: preferredStyle, delegate: self) })
    }
    
    private func loadActionViewSections() -> [UIStackView] {
        var sections = [UIStackView]()
        var actionViews = loadActionViews()
        for _ in 0..<Int(ceil(Double(_actions.count)/3)) {
            let section = createSectionStack()
            var i = 0
            while (i < 3 && !actionViews.isEmpty) {
                let actionView = actionViews.removeFirst()
                section.addArrangedSubview(actionView)
                i += 1
            }
            sections.append(section)
        }
        return sections
    }
    
    private func createSectionStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }
    
    /*
     *  MARK: - Objective-C methods
     */
    
    @objc private func didTapBackground() {
        guard tapBackgroundToDismiss else { return }
        didPressCancel()
    }
    
    @IBAction private func didPressCancel() {
        dismiss(animated: true, completion: cancelAction?.performHandler)
    }
    
    @objc private func draggedView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        switch sender.state {
        case .cancelled, .failed, .ended:
            let neededOffset = ((29/72) * containerView.frame.height)
            let velocity = sender.velocity(in: self.view).y
            if canDragToDismiss, (translation.y > neededOffset || velocity > 1500) {
                didPressCancel()
            } else {
                resetTransform()
            }
            
        default:
            containerView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: translation.y)
            guard translation.y < 0 else { return }
            whiteView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: -translation.y)
        }
    }
    
    private func resetTransform() {
        UIView.animate(withDuration: 0.7, delay: 0,
                       usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5,
                       options: .layoutSubviews, animations: {
                        self.containerView.transform = .identity
                        self.whiteView.transform = .identity
        }, completion: nil)
    }
    
}

extension DMActionController: DMActionViewDelegate {
    func actionView(_ actionView: DMActionView, wasSelectedWith action: DMAction) {
        dismiss(animated: true, completion: action.performHandler)
    }
}

extension DMActionController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.view { return true }
        return false
    }
}
