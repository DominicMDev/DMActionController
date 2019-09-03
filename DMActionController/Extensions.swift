//
//  Extensions.swift
//  DMActionController
//
//  Created by Dominic Miller on 9/2/19.
//  Copyright © 2019 Dominic Miller (dominicmdev@gmail.com)
//

import UIKit

internal extension UIFont {
    
    func withRegularWeightAddingSize(_ sizeToAdd: CGFloat) -> UIFont {
        let size = pointSize + sizeToAdd
        guard let fontName = self.fontName.components(separatedBy: "-").first,
            let newFont = UIFont(name: fontName, size: size) else { return .systemFont(ofSize: size) }
        return newFont
    }
    
}

internal extension Optional where Wrapped == String {
    
    var isNilOrEmpty: Bool {
        guard let string = self else { return true }
        return string.isEmpty
    }
    
}

internal extension UIView {
    func maskCorners(_ corners: UIRectCorner, cornerRadius: CGFloat) {
        guard cornerRadius > 0 else { return (self.layer.mask = nil) }
        let rounded = UIBezierPath(roundedRect: self.bounds,
                                   byRoundingCorners: corners,
                                   cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        self.layer.mask = shape
    }
}
