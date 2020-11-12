//
//  BaseViewController.swift
//  CloudspadeIos
//
//  Created by GNS065 on 22/10/20.
//  Copyright © 2020 CloudspadeIosOrganizationName. All rights reserved.
//

import SwiftUI
import Foundation

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var menuButton: UIButton!
    
    @IBOutlet var refreshButton: UIButton!
    
    @IBOutlet var filterButton: UIButton!
    
    var filterPageIsPresent:Bool = false
    var menuPageIsPresent:Bool = false
    var upperHeightForFilter = CGFloat()
    
    override func viewDidLoad() {
     super.viewDidLoad()
     self.filterButton.isHidden = false
     self.refreshButton.isHidden = false
     filterPageIsPresent = false
     menuPageIsPresent = false
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Executive", bundle: nil)
        let executiveController: ExecutiveViewController = mainStoryboard.instantiateViewController(withIdentifier: "ExecutiveId") as! ExecutiveViewController
         
        executiveController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(executiveController)
        containerView.addSubview(executiveController.view)
        setupConstraints(for: executiveController.view)
        self.upperHeightForFilter = executiveController.customerSummaryUpperPart.frame.size.height
       executiveController.didMove(toParent: self)
        
       
        
    }
    
    @IBAction func didFilterButton(_ sender: Any) {
        
        if(filterPageIsPresent==false){
            /*
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .transitionFlipFromRight) {
            self.filterButton.isHidden = false
            self.refreshButton.isHidden = false
            let filterViewController = self.storyboard?.instantiateViewController(withIdentifier: "filterViewController") as? FilterViewController
            filterViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.containerView.addSubview(filterViewController!.view)
            self.setupConstraintsForFilter(for: filterViewController!.view)
            filterViewController!.didMove(toParent: self)
            
            self.filterPageIsPresent = true
        } completion: { (true) in
            
        }
            */
            self.menuPageIsPresent = false
            self.filterPageIsPresent = true
            UIView.transition(with: self.containerView, duration: 0.5, options: .transitionFlipFromRight, animations: {
                let filterController = self.storyboard?.instantiateViewController(withIdentifier: "filterViewController") as? FilterViewController
                filterController!.view.translatesAutoresizingMaskIntoConstraints = false
                filterController!.view.isUserInteractionEnabled = true
                self.addChild(filterController!)
                self.containerView.addSubview(filterController!.view)
                self.setupConstraintsForFilter(for: filterController!.view)
                filterController!.didMove(toParent: self)
            }, completion: nil)
    }
        else{
            self.menuPageIsPresent = false
            self.filterButton.isHidden = false
            self.refreshButton.isHidden = false
            self.filterPageIsPresent = false
            
            UIView.transition(with: self.containerView, duration: 0.5, options: .transitionFlipFromRight, animations: {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Executive", bundle: nil)
                let executiveController: ExecutiveViewController = mainStoryboard.instantiateViewController(withIdentifier: "ExecutiveId") as! ExecutiveViewController
              
                executiveController.view.translatesAutoresizingMaskIntoConstraints = false
                self.addChild(executiveController)
                self.containerView.addSubview(executiveController.view)
                self.setupConstraints(for: executiveController.view)
                executiveController.didMove(toParent: self)
                self.upperHeightForFilter = executiveController.reportImage.frame.size.height
            }, completion: nil)
   
        }
     
    }
    func activateButtons(){
        
        self.filterButton.isHidden = false
        self.refreshButton.isHidden = false
        filterPageIsPresent = false
        menuPageIsPresent = false
    }
    func loadMainSectionScene(present viewController: UIViewController) {
          
        
        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(viewController)
        self.containerView.addSubview(viewController.view)
            setupConstraints(for: viewController.view)
            
            viewController.didMove(toParent: self)
        }
    
  
    @IBAction func menuButtonTap(_ sender: Any) {
        /*
        let filtertrans = CATransition()
        let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        filtertrans.duration = 0.5
        filtertrans.type = CATransitionType.push
        filtertrans.subtype = CATransitionSubtype.fromLeft
        filtertrans.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.containerView.window!.layer.add(filtertrans, forKey: kCATransition)
       
        present(menuViewController!, animated: false)
        */
      // let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
       // self.containerView.addSubview(menuViewController!.view)
       
        if(menuPageIsPresent==false){
            self.filterButton.isHidden = true
            self.refreshButton.isHidden = true
           
            /*
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveLinear
            ) { [self] in
               
            let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
            menuViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.containerView.addSubview(menuViewController!.view)
            setupConstraints(for: menuViewController!.view)
            menuViewController!.didMove(toParent: self)
            self.menuPageIsPresent = true
        } completion: { (true) in
            
        }
          */
            UIView.transition(with: self.containerView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
                menuViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.addChild(menuViewController!)
                self.containerView.addSubview(menuViewController!.view)
                self.setupConstraints(for: menuViewController!.view)
                menuViewController!.didMove(toParent: self)
                self.menuPageIsPresent = true
           }, completion: nil)
            
            
            /*
            let filtertrans = CATransition()
            let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
            filtertrans.duration = 0.5
            filtertrans.type = CATransitionType.push
            filtertrans.subtype = CATransitionSubtype.fromLeft
            filtertrans.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            self.containerView.window!.layer.add(filtertrans, forKey: kCATransition)
           
            present(menuViewController!, animated: false)
            */
        }
        else{
            self.filterButton.isHidden = false
            self.refreshButton.isHidden = false
            self.menuPageIsPresent = false
            
            /*
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Executive", bundle: nil)
            let executiveController: ExecutiveViewController = mainStoryboard.instantiateViewController(withIdentifier: "ExecutiveId") as! ExecutiveViewController
            executiveController.view.translatesAutoresizingMaskIntoConstraints = false
            addChild(executiveController)
            self.containerView.addSubview(executiveController.view)
            setupConstraints(for: executiveController.view)
            executiveController.didMove(toParent: self)
            self.upperHeightForFilter = executiveController.reportImage.frame.size.height
             */
            
            UIView.transition(with: self.containerView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Executive", bundle: nil)
                let executiveController: ExecutiveViewController = mainStoryboard.instantiateViewController(withIdentifier: "ExecutiveId") as! ExecutiveViewController
              
                executiveController.view.translatesAutoresizingMaskIntoConstraints = false
                self.addChild(executiveController)
                self.containerView.addSubview(executiveController.view)
                self.setupConstraints(for: executiveController.view)
                executiveController.didMove(toParent: self)
                self.upperHeightForFilter = executiveController.reportImage.frame.size.height
            }, completion: nil)
   
            
        }
       
        /*
      let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        UIView.transition(from: self.view, to: (menuViewController?.view)!, duration: 4, options: .transitionFlipFromLeft) { (true) in
            self.containerView.addSubview(menuViewController!.view)
        }
 */
    }
    private func setupConstraints(for childViewController: UIView) {
           NSLayoutConstraint.activate([
               childViewController.topAnchor.constraint(equalTo: containerView.topAnchor),
               childViewController.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
               childViewController.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
               childViewController.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor)
           ])
       }
    
    
     func setupConstraintsForFilter(for childViewController: UIView) {
        NSLayoutConstraint.activate([
            childViewController.topAnchor.constraint(equalTo: containerView.topAnchor, constant: self.upperHeightForFilter+10),
          //  childViewController.topAnchor.constraint(equalTo: containerView.topAnchor),
            childViewController.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            childViewController.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            childViewController.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
 
}
