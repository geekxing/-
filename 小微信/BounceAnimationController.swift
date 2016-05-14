//
//  BounceAnimationController.swift
//  StoreSearch
//
//  Created by 赖霄冰 on 16/4/17.
//  Copyright © 2016年 小辉辉. All rights reserved.
//

import UIKit

class  BounceAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey),
            let containerView = transitionContext.containerView() {
            toView.frame = transitionContext.finalFrameForViewController(toViewController)
            
            containerView.addSubview(toView)
            toView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            UIView.animateKeyframesWithDuration(transitionDuration(transitionContext), delay: 0, options: .CalculationModeCubic, animations: {
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.7, animations: {
                    toView.transform = CGAffineTransformMakeScale(2.0, 2.0)
                })
                }, completion: { finished in
                    transitionContext.completeTransition(finished)
            })
        }
    }
}
