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
        
        let splitViewController = window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers.last as! UINavigationController
        navigationController.topViewController?.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        
        let keys = WaterclosetwizardKeys()
        SparkCloud.sharedInstance().OAuthClientId = keys.oAuthClientId()
        SparkCloud.sharedInstance().OAuthClientSecret = keys.oAuthSecret()
        SparkCloud.sharedInstance().loginWithUser(keys.particleUser(), password:keys.particlePassword()) { (error) in
            if ((error) != nil) {
                NSLog("Error logging in: \(error)")
            }
        }
        
        return true
    }
}

