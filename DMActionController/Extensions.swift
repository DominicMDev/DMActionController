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

extension UIRectCorner {
    
    public static var topCorners: UIRectCorner { [topLeft, topRight] }
    public static var bottomCorners: UIRectCorner { [bottomLeft, bottomRight] }
    public static var leftCorners: UIRectCorner { [topLeft, bottomLeft] }
    public static var rightCorners: UIRectCorner { [topRight, bottomRight] }
    
    public var caCornerMask: CACornerMask {
        switch self {
        case .topLeft: return .topLeft
        case .topRight: return .topRight
        case .bottomLeft: return .bottomLeft
        case .bottomRight: return .bottomRight
        case .topCorners: return .topCorners
        case .bottomCorners: return .bottomCorners
        case .leftCorners: return .leftCorners
        case .rightCorners: return .rightCorners
        case .allCorners: return .allCorners
        default:
            var rawValue: UInt = 0
            forEach {
                rawValue += $0.caCornerMask.rawValue
            }
            return CACornerMask(rawValue: rawValue)
        }
    }
    
    @inlinable public func forEach(_ body: (UIRectCorner) -> Void) {
        for corner: UIRectCorner in [.topLeft, .topRight, .bottomLeft, .bottomRight] {
            if self.contains(corner) {
                body(corner)
            }
        }
    }
    
}

extension CACornerMask {
    
    public static var layerMinXCorners: CACornerMask { [layerMinXMinYCorner, layerMinXMaxYCorner] }
    public static var layerMinYCorners: CACornerMask { [layerMinXMinYCorner, layerMaxXMinYCorner] }
    public static var layerMaxXCorners: CACornerMask { [layerMaxXMinYCorner, layerMaxXMaxYCorner] }
    public static var layerMaxYCorners: CACornerMask { [layerMinXMaxYCorner, layerMaxXMaxYCorner] }
    
    public static var layerAllCorners: CACornerMask {
        [layerMinXMinYCorner, layerMaxXMinYCorner, layerMinXMaxYCorner, layerMaxXMaxYCorner]
    }
    
    public static var topLeft: CACornerMask { layerMinXMinYCorner }
    public static var topRight: CACornerMask { layerMaxXMinYCorner }
    public static var bottomLeft: CACornerMask { layerMinXMaxYCorner }
    public static var bottomRight: CACornerMask { layerMaxXMaxYCorner }
    
    public static var topCorners: CACornerMask { layerMinYCorners }
    public static var bottomCorners: CACornerMask { layerMaxYCorners }
    public static var leftCorners: CACornerMask { layerMinXCorners }
    public static var rightCorners: CACornerMask { layerMaxXCorners }
    
    public static var allCorners: CACornerMask { layerAllCorners }
    
    public var uiRectCorner: UIRectCorner {
        switch self {
        case .layerMinXMinYCorner: return .topLeft
        case .layerMaxXMinYCorner: return .topRight
        case .layerMinXMaxYCorner: return .bottomLeft
        case .layerMaxXMaxYCorner: return .bottomRight
        case .topCorners: return .topCorners
        case .bottomCorners: return .bottomCorners
        case .leftCorners: return .leftCorners
        case .rightCorners: return .rightCorners
        case .allCorners: return .allCorners
        default:
            var rawValue: UInt = 0
            forEach {
                rawValue += $0.uiRectCorner.rawValue
            }
            return UIRectCorner(rawValue: rawValue)
        }
    }
    
    @inlinable public func forEach(_ body: (CACornerMask) -> Void) {
        for corner: CACornerMask in [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner] {
            if self.contains(corner) {
                body(corner)
            }
        }
    }
    
}

internal extension UIView {
    
    static var isInAnimationBlock: Bool { UIView.inheritedAnimationDuration != 0 }
    
    func maskCorners(_ corners: UIRectCorner, cornerRadius: CGFloat) {
        if #available(iOS 11.0, *) {
            layer.maskedCorners = corners.caCornerMask
            layer.cornerRadius = cornerRadius
        } else {
            setMask(for: corners, radius: cornerRadius)
        }
    }
    
    private func setMask(for corners: UIRectCorner, radius: CGFloat) {
        guard radius > 0 else { return (self.layer.mask = nil) }
        let rounded = UIBezierPath(roundedRect: self.bounds,
                                   byRoundingCorners: corners,
                                   cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        self.layer.mask = shape
    }
    
}

class _DMActionControllerContentView: UIView {
    
    var cornerRadius: CGFloat = DMActionControllerAppearance.shared.cornerRadius { didSet { updateMask() } }
    var maskedCorners: UIRectCorner = .topCorners { didSet { updateMask() } }
    
    var lastMaskedCorners: UIRectCorner = .allCorners
    var lastCornerRadius: CGFloat = 0
    var lastBounds: CGRect?
    
    private var needsUpdate: Bool {
        lastCornerRadius != cornerRadius || lastMaskedCorners != maskedCorners || needsUpdateForBounds
    }
    
    private var needsUpdateForBounds: Bool {
        if #available(iOS 11.0, *) {
            return false
        } else {
            return lastBounds != bounds
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateMask()
    }
    
    private func updateMask() {
        guard needsUpdate else { return }
        setLastValues()
        maskCorners(maskedCorners, cornerRadius: cornerRadius)
    }
    
    private func setLastValues() {
        lastBounds = bounds
        lastCornerRadius = cornerRadius
        lastMaskedCorners = maskedCorners
    }
    
}
