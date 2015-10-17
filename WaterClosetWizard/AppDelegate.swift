//
//  AppDelegate.swift
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/17/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Types
    
    struct MainStoryboard {
        static let name = "Main"
        
        struct Identifiers {
            static let emptyViewController = "emptyViewController"
        }
    }
    
    // MARK: Properties
    
    var window: UIWindow?
    
    
    // MARK: UIApplicationDelegate
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let keys : WaterclosetwizardKeys = WaterclosetwizardKeys.init()
        SparkCloud.sharedInstance().OAuthClientId = keys.oAuthClientId()
        SparkCloud.sharedInstance().OAuthClientSecret = keys.oAuthSecret()
        
        return true
    }
}

