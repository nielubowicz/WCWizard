//
//  AppDelegate.swift
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/17/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    // MARK: Properties
    
    var window: UIWindow?
    
    
    // MARK: UIApplicationDelegate
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let splitViewController : UISplitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController : UINavigationController = splitViewController.viewControllers.last as! UINavigationController
        navigationController.topViewController?.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        
        let keys : WaterclosetwizardKeys = WaterclosetwizardKeys.init()
        SparkCloud.sharedInstance().OAuthClientId = keys.oAuthClientId()
        SparkCloud.sharedInstance().OAuthClientSecret = keys.oAuthSecret()
        
        return true
    }
}

