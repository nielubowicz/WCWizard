//
//  MasterViewController.swift
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/17/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

import UIKit

class MasterViewController : UITableViewController {
    
    let dataSource = DeviceDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.reloadClosure = { (indexPaths) -> () in
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
            })
        }
        dataSource.insertClosure = { (indexPaths) -> () in
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
            })
        }
        self.tableView.dataSource = dataSource
    }
    
    override func viewWillAppear(animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let keys : WaterclosetwizardKeys = WaterclosetwizardKeys()
        SparkCloud.sharedInstance().loginWithUser(keys.particleUser(), password:keys.particlePassword()) { (error) -> Void in
            if ((error) != nil) {
                NSLog("Error logging in: \(error)")
            }
            SparkCloud.sharedInstance().subscribeToAllEventsWithPrefix(self.kWCWEventPrefix) { (event, error) in
                if (error == nil) {
                    self.dataSource.parseEvent(event)
                }
                else {
                    NSLog("Error subscribing to events: \(error)")
                }
            }
            
            SparkCloud.sharedInstance().getDevices { (devices, error) -> Void in
                if (error == nil) {
                    for device in devices {
                        device.getVariable("name", completion: { (deviceName, error) -> Void in
                            let sparkEvent = SparkEvent(eventDict: ["data":deviceName, "event":self.kWCWEventPrefix])
                            self.dataSource.parseEvent(sparkEvent)
                        })
                    }
                }
                else {
                    NSLog("Error getting device list: \(error)")
                }
            }
        }
    }
}