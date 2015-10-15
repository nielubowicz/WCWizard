//
//  WCWRoomEvent.m
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/14/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

#import "WCWRoomEvent.h"

@implementation WCWRoomEvent

- (nonnull instancetype)initWithSparkEvent:(SparkEvent *)event {
    if (self = [super init]) {
        _roomLocation = event.data;
        _roomOccupied = [event.event containsString:@"Occupied"];
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    BOOL isEqual = NO;
    if ([object isKindOfClass:[WCWRoomEvent class]]) {
        WCWRoomEvent *otherObject = (WCWRoomEvent *)object;
        isEqual = [otherObject.roomLocation isEqualToString:self.roomLocation];
    }
    return isEqual;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ is %@", self.roomLocation, (self.roomOccupied ? @"not occupied" : @"occupied")];
}

@end
