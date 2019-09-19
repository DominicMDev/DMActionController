//
//  DMActionController+Preferences.swift
//  DMActionController
//
//  Created by Dominic Miller on 9/10/19.
//  Copyright © 2019 App-Order. All rights reserved.
//

import UIKit

extension DMActionController {
    
    /// TODO: Document and maybe observe these to realtime update view.
    public struct Preferences {
        
        /*
         *  MARK: - Display
         */
        
        public var sheetCornerRadius: CGFloat = 10
        public var sheetColor: UIColor = .white
        public var sheetAccessoryColor: UIColor = .black
        public var titleColor: UIColor = .black
        public var titleFont: UIFont = .systemFont(ofSize: 17, weight: .semibold)
        public var messageFont: UIFont = .systemFont(ofSize: 12, weight: .regular)
        public var messageColor: UIColor = .darkGray
        public var alwaysShowCloseButton: Bool = true
        public var tableCellHeight: CGFloat = 48
        
        /*
         *  MARK: - Behavior
         */
        
        /// Specifies if dragging the view downward will act as though the user tapped on the cancel button.
        /// If `true`, when the user drags the view far enough downward and releases,
        /// the controller will be dismissed and the cancel action will occur.
        /// The default value of this property is `true`.
        public var dragToDismiss: Bool = true
        
        /// Specifies if tapping on the background will act as though the user tapped on the cancel button.
        /// If `true`, when the user taps on the background,
        /// the controller will be dismissed and the cancel action will occur.
        /// The default value of this property is `true`.
        public var tapBackgroundToDismiss: Bool = true
        
        public var topDraggableInset: CGFloat = 0
    }
    
}
