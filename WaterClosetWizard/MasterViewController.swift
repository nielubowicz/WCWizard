//
//  MasterViewController.swift
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/17/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

import UIKit

class MasterViewController : UITableViewController {
    
    var objects : Array = Array<WCWRoomEvent>()
    let kWCWEventPrefix : String = "Bathroom"

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        SparkCloud.sharedInstance().subscribeToAllEventsWithPrefix(kWCWEventPrefix) { (event : SparkEvent!, error : NSError!) -> Void in
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let roomEvent : WCWRoomEvent = WCWRoomEvent.init(sparkEvent: event)
                    if (self.objects.contains(roomEvent)) {
                        self.updateObject(roomEvent)
                    } else {
                        self.insertNewObject(roomEvent)
                    }
                });
            }
            else {
                NSLog("Error occured: %@",error.localizedDescription);
            }
        }
    }
    
    func insertNewObject(roomEvent: WCWRoomEvent!) -> Void {
        self.objects.insert(roomEvent, atIndex: 0)
        let indexPath : NSIndexPath = NSIndexPath.init(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func updateObject(roomEvent: WCWRoomEvent!) -> Void {
        let roomIndex : Int! = self.objects.indexOf(roomEvent)
        if (roomIndex == Int.max) {
            return;
        }
    
        self.objects[roomIndex] = roomEvent;
        let indexPath : NSIndexPath = NSIndexPath.init(forRow: roomIndex, inSection: 0)
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.objects.count <= 0) {
            return 1;
        }
        
        return self.objects.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (self.objects.count <= 0) {
            return tableView.dequeueReusableCellWithIdentifier("noWizardsCell")!
        }
        
        let cell : WCWRoomTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! WCWRoomTableViewCell
    
        let roomEvent : WCWRoomEvent = self.objects[indexPath.row]
        cell.textLabel?.text = roomEvent.roomLocation
        cell.isOccupied = roomEvent.roomOccupied;
    
        return cell;
    }
}