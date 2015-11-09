//
//  DeviceDataSource.swift
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 11/8/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

import UIKit

class DeviceDataSource : NSObject {
    
    var objects = [WCWRoomEvent]()
    var reloadClosure: ((indexPaths:[NSIndexPath]) -> ())?
    var insertClosure: ((indexPaths:[NSIndexPath]) -> ())?
 
    func parseEvent(event: SparkEvent!) {
        let roomEvent : WCWRoomEvent = WCWRoomEvent(sparkEvent: event)
        if (objects.contains(roomEvent)) {
            updateObject(roomEvent)
        } else {
            insertNewObject(roomEvent)
        }
    }
    
    func insertNewObject(roomEvent: WCWRoomEvent!) {
        objects.insert(roomEvent, atIndex: 0)
        let indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        if (objects.count == 1) {
            reloadClosure?(indexPaths: [indexPath])
        } else {
            insertClosure?(indexPaths: [indexPath])
        }
    }
    
    func updateObject(roomEvent: WCWRoomEvent!) {
        let roomIndex : Int! = objects.indexOf(roomEvent)
        if (roomIndex == Int.max) {
            return;
        }
        
        objects[roomIndex] = roomEvent;
        let indexPath : NSIndexPath = NSIndexPath(forRow: roomIndex, inSection: 0)
        reloadClosure?(indexPaths: [indexPath])
    }
}

// MARK: UITableViewDataSource methods
extension DeviceDataSource : UITableViewDataSource {
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (objects.isEmpty) {
            return 1;
        }
        
        return objects.count;
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (objects.count <= 0) {
            return tableView.dequeueReusableCellWithIdentifier("noWizardsCell", forIndexPath: indexPath)
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! WCWRoomTableViewCell
        
        let roomEvent = objects[indexPath.row]
        cell.textLabel?.text = roomEvent.roomLocation
        cell.isOccupied = roomEvent.roomOccupied;
        
        return cell;
    }
}