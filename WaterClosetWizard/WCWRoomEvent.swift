//
//  WCWRoomEvent.swift
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/15/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

import Foundation

class WCWRoomEvent : NSObject {
    var roomOccupied : Bool
    var roomLocation : String
    
    init(sparkEvent event:SparkEvent) {
        roomLocation = event.data
        roomOccupied = event.event.containsString("Occupied")
        super.init()
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        var isEqual: Bool = false
        if object is WCWRoomEvent {
            let otherObject = object as! WCWRoomEvent
            isEqual = (otherObject.roomLocation == self.roomLocation)
        }
        
        return isEqual
    }
}

