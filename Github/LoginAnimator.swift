//
//  LoginAnimator.swift
//  Github
//
//  Created by Austin Cherry on 6/1/15.
//  Copyright (c) 2015 Vluxe. All rights reserved.
//

import UIKit

class LoginAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        //let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromView = fromViewController.view //transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let animationDuration = self.transitionDuration(transitionContext) / 5
        
        let point = CGPointMake(fromView.frame.origin.x, fromView.frame.origin.y)
        fromView.layer.anchorPoint = CGPointMake(0, 0)
        fromView.center = point
        let rotationTransform = CGAffineTransformIdentity
        
        container!.addSubview(toView)
        container!.addSubview(fromView)
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            fromView.transform = CGAffineTransformRotate(rotationTransform, self.degreesToRadians(80))
            }, completion: { (f: Bool) -> Void in
                UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                    fromView.transform = CGAffineTransformRotate(rotationTransform, self.degreesToRadians(70))
                    }, completion: { (f: Bool) -> Void in
                        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                            fromView.transform = CGAffineTransformRotate(rotationTransform, self.degreesToRadians(80))
                            }, completion: { (f: Bool) -> Void in
                                UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                                    fromView.transform = CGAffineTransformRotate(rotationTransform, self.degreesToRadians(70))
                                    }, completion: { (f: Bool) -> Void in
                                        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                                            var frame = fromView.frame
                                            frame.origin.y = fromView.window!.frame.size.height
                                            fromView.frame = frame
                                            }, completion: { (f: Bool) -> Void in
                                                fromView.transform = CGAffineTransformRotate(rotationTransform, self.degreesToRadians(0))
                                                transitionContext.completeTransition(true)
                                        })
                                })
                        })
                })
        })
        
    }
    
    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return (degrees * CGFloat(M_PI) / 180)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}