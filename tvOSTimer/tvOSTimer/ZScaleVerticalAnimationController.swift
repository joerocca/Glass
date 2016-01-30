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
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
        
        let containerView = transitionContext.containerView()
        
        let bounds = UIScreen.mainScreen().bounds
        
        
        if self.reverse
        {
            toViewController.view.transform = CGAffineTransformMakeScale(0.90, 0.90)
            containerView!.addSubview(toViewController.view)
            containerView!.addSubview(fromViewController.view)
        }
        else
        {
            toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height)
            containerView!.addSubview(toViewController.view)
        }
        
        
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.90, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: {
            
            
            if self.reverse
            {
                //                    fromViewController.view.alpha = 0.0
                fromViewController.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height)
                toViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
                toViewController.view.frame = finalFrameForVC
                
            }
            else
            {
                fromViewController.view.alpha = 0.8
                fromViewController.view.transform = CGAffineTransformMakeScale(0.90, 0.90)
                toViewController.view.frame = finalFrameForVC
            }
            
            
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                fromViewController.view.alpha = 1.0
                fromViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
        
        
    }
}