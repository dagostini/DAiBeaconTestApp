//
//  AppDelegate.m
//  DAiBeaconTestApp
//
//  Created by Dejan on 06/07/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) CLLocationManager *locationManager;

@end


@implementation AppDelegate


#pragma mark - Getters

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
    }
    return _locationManager;
}


#pragma mark - Add/Remove Beacons

- (void)startMonitoringRegion:(CLBeaconRegion *)region {
    [self.locationManager startMonitoringForRegion:region];
    [self.locationManager startRangingBeaconsInRegion:region];
}

- (void)stopMonitoringRegion:(CLBeaconRegion *)region {
    [self.locationManager stopMonitoringForRegion:region];
    [self.locationManager stopRangingBeaconsInRegion:region];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    for (CLBeacon *beacon in beacons) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDAiBeaconTestAppDidRangeBeaconsNotification object:nil userInfo:@{kDAiBeaconObjectKey: beacon}];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        [self sendRequestWithRegion:(CLBeaconRegion *)region andAction:@"enter"];
        UILocalNotification *localNotification = [UILocalNotification new];
        localNotification.alertBody = [NSString stringWithFormat:@"Did enter region: %@", region.identifier];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        [self sendRequestWithRegion:(CLBeaconRegion *)region andAction:@"exit"];
        UILocalNotification *localNotification = [UILocalNotification new];
        localNotification.alertBody = [NSString stringWithFormat:@"Did exit region: %@", region.identifier];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}


#pragma mark - Networking

- (void)sendRequestWithRegion:(CLBeaconRegion *)region andAction:(NSString *)action {
    NSString *requestString = [[NSString stringWithFormat:@"http://daibeacontestserver.appspot.com/?userID=testUser&deviceID=testDevice&regionID=%@&regionName=%@&action=%@&timestamp=%@", region.proximityUUID.UUIDString, region.identifier, action, [NSDate date]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *requestUrl = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   NSLog(@"Server request finished with error: %@", connectionError.localizedDescription);
                               }
                           }];
}


@end
