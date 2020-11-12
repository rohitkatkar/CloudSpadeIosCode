//
//  SlideInTransition.swift
//  CloudspadeIos
//
//  Created by GNS065 on 21/09/20.
//  Copyright © 2020 CloudspadeIosOrganizationName. All rights reserved.
//

import UIKit

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning{
    var isPresenting = false
    let dimmingView = UIView()
    var slideInNavBar = CGFloat()
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewcontroller = transitionContext.viewController(forKey: .from) else {return}
        
        let containerView = transitionContext.containerView
        let finalWidth = toViewController.view.bounds.width
        let finalHeight = toViewController.view.bounds.height
     
       /*
         print("***********************")
        print(slideInNavBar)
        print("***********************")*/
        if isPresenting {
        dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
           containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            
            //Add menu view Controller to container
            containerView.addSubview(toViewController.view)
           
            //Init frame off the screen
            toViewController.view.frame = CGRect(x: -finalWidth, y: slideInNavBar + 18, width: finalWidth, height: finalHeight)
        }
        
        //Animate on screen
        let transform = {
           self.dimmingView.alpha = 0.0
            
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
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
