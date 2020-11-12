//
//  FilterSlideInTransition.swift
//  CloudspadeIos
//
//  Created by GNS065 on 19/10/20.
//  Copyright © 2020 CloudspadeIosOrganizationName. All rights reserved.
//

import SwiftUI

class FilterSlideInTransition: NSObject, UIViewControllerAnimatedTransitioning{
    var isPresenting = false
    let dimmingView = UIView()
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewcontroller = transitionContext.viewController(forKey: .from) else {return}
        
        let containerView = transitionContext.containerView
        let finalWidth = toViewController.view.bounds.width 
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting {
        dimmingView.backgroundColor = .black
        dimmingView.alpha = 0.0
        containerView.addSubview(dimmingView)
        dimmingView.frame = containerView.bounds
            
            //Add menu view Controller to container
            containerView.addSubview(toViewController.view)
           
            
            //Init frame off the screen
            toViewController.view.frame = CGRect(x: finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //Animate on screen
        let transform = {
           self.dimmingView.alpha = 0.5
            
            toViewController.view.transform = CGAffineTransform(translationX: -finalWidth, y: 0)
        }
        
        //Animate back off screen
        
        let identity = {
           self.dimmingView.alpha = 0.0
            fromViewcontroller.view.transform = .identity
        }
        
        //
        let duration = transitionDuration(using: transitionContext)
        let isCanceled = transitionContext.transitionWasCancelled
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, animations: {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCanceled)
        }

        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    


}
