//
//  WCWRoomEvent.h
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/14/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SparkEvent.h"

@interface WCWRoomEvent : NSObject

@property (nonatomic, assign, readonly) BOOL roomOccupied;
@property (nonatomic, copy, readonly, nonnull) NSString *roomLocation;

- (nonnull instancetype)initWithSparkEvent:(nonnull SparkEvent *)event;

@end
