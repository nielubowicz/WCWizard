//
//  WCWRoomTableViewCell.swift
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/15/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

import UIKit

@objc(WCWRoomTableViewCell)

public class WCWRoomTableViewCell : UITableViewCell {
    var isOccupied : Bool = false {
        didSet {
            if (self.accessoryView == nil) {
                let accessoryView : UIView = UIView.init(frame:CGRectMake(0, 0, 44, 44));
                accessoryView.layer.cornerRadius = 22;
                self.accessoryView = accessoryView;
            }
            
            var backgroundColor : UIColor
            if (self.isOccupied) {
                backgroundColor = UIColor.redColor()
            } else {
                backgroundColor = UIColor.greenColor()
            }
            self.accessoryView?.backgroundColor = backgroundColor
            self.setNeedsDisplay()
        }
    }
    
    init() {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "RoomTableViewCell")
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}