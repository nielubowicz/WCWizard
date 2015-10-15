//
//  MasterViewController.h
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/14/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

