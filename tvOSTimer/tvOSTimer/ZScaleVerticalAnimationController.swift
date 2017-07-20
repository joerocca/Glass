//
//  ZScaleVerticalAnimationController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/26/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class ZScaleVerticalAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var reverse: Bool = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        
        let containerView = transitionContext.containerView
        
        let bounds = UIScreen.main.bounds
        
        
        if self.reverse {
            toViewController.view.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
            containerView.addSubview(toViewController.view)
            containerView.addSubview(fromViewController.view)
        } else {
            toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
            containerView.addSubview(toViewController.view)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.90, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations: {
            
            if self.reverse {
                //                    fromViewController.view.alpha = 0.0
                fromViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
                toViewController.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                toViewController.view.frame = finalFrameForVC
                
            } else {
                fromViewController.view.alpha = 0.8
                fromViewController.view.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
                toViewController.view.frame = finalFrameForVC
            }
            
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                fromViewController.view.alpha = 1.0
                fromViewController.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
    }
}
