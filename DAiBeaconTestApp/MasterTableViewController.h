//
//  MasterTableViewController.h
//  DAiBeaconTestApp
//
//  Created by Dejan on 06/07/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLBeaconRegion.h>
#import "DetailViewController.h"
#import "NewItemViewController.h"

#define kDAiBeaconTestAppDataKey @"kDAiBeaconTestAppDataKey"

@interface MasterTableViewController : UITableViewController <AddNewItemDelegate>

@end
