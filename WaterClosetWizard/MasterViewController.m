//
//  MasterViewController.m
//  WaterClosetWizard
//
//  Created by Chris Nielubowicz on 10/14/15.
//  Copyright © 2015 Mobiquity, Inc. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "WCWRoomTableViewCell.h"
#import "WCWRoomEvent.h"

#import "SparkCloud.h"

@interface MasterViewController ()

@property NSMutableArray *objects;

@end

static NSString * const kWCWEventPrefix = @"Bathroom";

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    SparkEventHandler handler = ^(SparkEvent *event, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                WCWRoomEvent *roomEvent = [[WCWRoomEvent alloc] initWithSparkEvent:event];
                if ([self.objects containsObject:roomEvent]) {
                    [self updateObject:roomEvent];
                } else {
                    [self insertNewObject:roomEvent];
                }
            });
        }
        else {
            NSLog(@"Error occured: %@",error.localizedDescription);
        }
    };
    
    [[SparkCloud sharedInstance] subscribeToAllEventsWithPrefix:kWCWEventPrefix handler:handler];
}

- (void)insertNewObject:(WCWRoomEvent *)roomEvent {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:roomEvent atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)updateObject:(WCWRoomEvent *)roomEvent {
    NSUInteger roomIndex = [self.objects indexOfObject:roomEvent];
    if (roomIndex == NSUIntegerMax) {
        return;
    }
    
    [self.objects replaceObjectAtIndex:roomIndex withObject:roomEvent];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:roomIndex inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCWRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    WCWRoomEvent *roomEvent = self.objects[indexPath.row];
    cell.textLabel.text = roomEvent.roomLocation;
    cell.isOccupied = roomEvent.roomOccupied;
    
    return cell;
}

@end
