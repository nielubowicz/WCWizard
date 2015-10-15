//
//  WCWRoomTableViewCell.m
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/14/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

#import "WCWRoomTableViewCell.h"

@implementation WCWRoomTableViewCell

- (void)setIsOccupied:(BOOL)isOccupied {
    _isOccupied = isOccupied;
    
    if (self.accessoryView == nil) {
        UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        accessoryView.layer.cornerRadius = 22;
        self.accessoryView = accessoryView;
    }
    
    UIColor *backgroundColor;
    if (self.isOccupied) {
        backgroundColor = [UIColor redColor];
    } else {
        backgroundColor = [UIColor greenColor];
    }
    [self.accessoryView setBackgroundColor:backgroundColor];
    [self setNeedsDisplay];
}

@end
