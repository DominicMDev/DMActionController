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

internal extension UIRectCorner {
    
    static var topCorners: UIRectCorner { [topLeft, topRight] }
    static var bottomCorners: UIRectCorner { [bottomLeft, bottomRight] }
    static var leftCorners: UIRectCorner { [topLeft, bottomLeft] }
    static var rightCorners: UIRectCorner { [topRight, bottomRight] }
    
    var caCornerMask: CACornerMask {
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
    
    @inlinable func forEach(_ body: (UIRectCorner) -> Void) {
        for corner: UIRectCorner in [.topLeft, .topRight, .bottomLeft, .bottomRight] {
            if self.contains(corner) {
                body(corner)
            }
        }
    }
    
}

internal extension CACornerMask {
    
    static var layerMinXCorners: CACornerMask { [layerMinXMinYCorner, layerMinXMaxYCorner] }
    static var layerMinYCorners: CACornerMask { [layerMinXMinYCorner, layerMaxXMinYCorner] }
    static var layerMaxXCorners: CACornerMask { [layerMaxXMinYCorner, layerMaxXMaxYCorner] }
    static var layerMaxYCorners: CACornerMask { [layerMinXMaxYCorner, layerMaxXMaxYCorner] }
    
    static var layerAllCorners: CACornerMask {
        [layerMinXMinYCorner, layerMaxXMinYCorner, layerMinXMaxYCorner, layerMaxXMaxYCorner]
    }
    
    static var topLeft: CACornerMask { layerMinXMinYCorner }
    static var topRight: CACornerMask { layerMaxXMinYCorner }
    static var bottomLeft: CACornerMask { layerMinXMaxYCorner }
    static var bottomRight: CACornerMask { layerMaxXMaxYCorner }
    
    static var topCorners: CACornerMask { layerMinYCorners }
    static var bottomCorners: CACornerMask { layerMaxYCorners }
    static var leftCorners: CACornerMask { layerMinXCorners }
    static var rightCorners: CACornerMask { layerMaxXCorners }
    
    static var allCorners: CACornerMask { layerAllCorners }
    
    var uiRectCorner: UIRectCorner {
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
    
    @inlinable func forEach(_ body: (CACornerMask) -> Void) {
        for corner: CACornerMask in [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner] {
            if self.contains(corner) {
                body(corner)
            }
        }
    }
    
}

internal extension UIView {
    
    static var isInAnimationBlock: Bool { UIView.inheritedAnimationDuration != 0 }
    
    func addConstrainedSubview(_ subview: UIView, constant: CGFloat = 0,
                               top: Bool = true , bottom: Bool = true,
                               leading: Bool = true, trailing: Bool = true) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        if top {
            subview.topAnchor.constraint(equalTo: topAnchor, constant: constant).isActive = true
        }
        if bottom {
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant).isActive = true
        }
        if leading {
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant).isActive = true
        }
        if trailing {
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constant).isActive = true
        }
    }
    
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
