//
//  WCWRoomTableViewCell.swift
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/15/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

import UIKit

class WCWRoomTableViewCell : UITableViewCell {
    var isOccupied : Bool = false {
        didSet {
            if (accessoryView == nil) {
                let accessoryView : UIView = UIView(frame:CGRectMake(0, 0, 44, 44))
                accessoryView.layer.cornerRadius = 22
                self.accessoryView = accessoryView
            }
            
            let backgroundColor : UIColor
            if (isOccupied) {
                backgroundColor = UIColor.redColor()
            } else {
                backgroundColor = UIColor.greenColor()
            }
            accessoryView?.backgroundColor = backgroundColor
            setNeedsDisplay()
        }
    }
}