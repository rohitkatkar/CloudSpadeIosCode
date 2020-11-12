//
//  LoadController.swift
//  CloudspadeIos
//
//  Created by GNS065 on 05/11/20.
//  Copyright © 2020 CloudspadeIosOrganizationName. All rights reserved.
//

import Foundation
import UIKit

import SalesforceSDKCore

class LoaderController: NSObject {

static let sharedInstance = LoaderController()
private let activityIndicator = UIActivityIndicatorView()
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var holdingView = UIView()
    
//MARK: - Private Methods -
private func setupLoader() {
    removeLoader()
    holdingView = appDel.window!.rootViewController!.view!
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = .gray
}

//MARK: - Public Methods -
func showLoader() {
    setupLoader()

    //let appDel = UIApplication.shared.delegate as! AppDelegate
    //let holdingView = appDel.window!.rootViewController!.view!

    DispatchQueue.main.async {
        self.activityIndicator.center = self.holdingView.center
        self.activityIndicator.startAnimating()
        self.holdingView.addSubview(self.activityIndicator)
        self.holdingView.alpha = 0.4
        
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
}

func removeLoader(){
    DispatchQueue.main.async {
        self.holdingView.alpha = 1.0
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
}
