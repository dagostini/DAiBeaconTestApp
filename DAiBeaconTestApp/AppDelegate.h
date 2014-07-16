//
//  AppDelegate.h
//  DAiBeaconTestApp
//
//  Created by Dejan on 06/07/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;

#pragma mark - Add/Remove Beacons
- (void)startMonitoringRegion:(CLBeaconRegion *)region;
- (void)stopMonitoringRegion:(CLBeaconRegion *)region;

@end
