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
        SparkCloud.sharedInstance().loginWithUser(keys.particleUser(), password:keys.particlePassword()) { (error) in
            if ((error) != nil) {
                NSLog("Error logging in: \(error)")
            }
            SparkCloud.sharedInstance().subscribeToAllEventsWithEventPrefix(.OccupancyChanged, handler: { (event, error) in
                guard error == nil else { NSLog("Error subscribing to events: \(error)"); return }
                
                NSLog("Event received: \(event)")
                self.dataSource.parseEvent(event)
            })
            
            SparkCloud.sharedInstance().getDevices { (devices, error) in
                guard error == nil else { NSLog("Error getting device list: \(error)"); return }
                
                for device in devices {
                    device.getVariable("name", completion: { (deviceName, error) in
                        let sparkEvent = SparkEvent(eventDict: ["data":deviceName, "event": EventPrefix.OccupancyChanged.rawValue])
                        sparkEvent.deviceID = device.id
                        device.getVariable("ocupado", completion: { (occupiedValue, error) in
                            if (occupiedValue.isEqual(1)) {
                                sparkEvent.data.appendContentsOf(", Occupied")
                            }
                            NSLog("Event created: \(sparkEvent)")
                            self.dataSource.parseEvent(sparkEvent)
                        })
                    })
                }
            }
        }
    }
}