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
        let roomData = event.data.characters.split{$0 == ","}.map(String.init)
        roomLocation = roomData[0]
        if (roomData.count > 1) {
            roomOccupied = roomData[1].containsString("Occupied")
        } else {
            roomOccupied = false
        }
        super.init()
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        var isEqual = false
        if object is WCWRoomEvent {
            let otherObject = object as! WCWRoomEvent
            isEqual = (otherObject.roomLocation == self.roomLocation)
        }
        
        return isEqual
    }
}

