//
//  DMActionController+Animations.swift
//  DMActionController
//
//  Created by Dominic Miller on 7/30/19.
//  Copyright © 2019 Dominic Miller (dominicmdev@gmail.com)
//

import UIKit

extension DMActionController: UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    public func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented.isKind(of: DMActionController.self) {
            return self
        }
        return nil
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed.isKind(of: DMActionController.self) {
            return self
        }
        return nil
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toController = transitionContext.viewController(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: toController)
        let actionController: DMActionController
        var isPresenting = false
        if let vc = toController as? DMActionController {
            actionController = vc
            isPresenting = true
        } else {
            actionController = transitionContext.viewController(forKey: .from)! as! DMActionController
        }
        actionController.view.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        let dismissedTransform = CGAffineTransform.identity.translatedBy(x: 0, y: UIScreen.main.bounds.height)
        if isPresenting {
            actionController.view.frame = finalFrame
            containerView.addSubview(actionController.view)
            actionController.view.backgroundColor = .clear
            actionController.containerView.transform = dismissedTransform
            containerView.bringSubviewToFront(actionController.view)
        }
        UIView.animate(
            withDuration: 0.7,
            delay:0.0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.5,
            animations: {
                actionController.view.backgroundColor = isPresenting ? UIColor(white: 0, alpha: 0.5) : .clear
                actionController.containerView.transform = isPresenting ? .identity : dismissedTransform
        }, completion: { _ in
            if !isPresenting { actionController.view.removeFromSuperview() }
            transitionContext.completeTransition(true)
        })
    }
    
}
