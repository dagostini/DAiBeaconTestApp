//
//  DetailViewController.h
//  DAiBeaconTestApp
//
//  Created by Dejan on 06/07/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLBeaconRegion.h>

@interface DetailViewController : UIViewController

- (id)initWithBeacon:(CLBeaconRegion *)beacon;

@end
