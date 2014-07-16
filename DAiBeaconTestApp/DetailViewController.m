//
//  DetailViewController.m
//  DAiBeaconTestApp
//
//  Created by Dejan on 06/07/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) CLBeaconRegion *beacon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *signalStrengthLabel;

@end

@implementation DetailViewController


#pragma mark - Initialization

- (id)initWithBeacon:(CLBeaconRegion *)beacon {
    self = [super init];
    if (self) {
        _beacon = beacon;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - View Management

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindGUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRangeBeaconNofitication:) name:kDAiBeaconTestAppDidRangeBeaconsNotification object:nil];
}

- (void)bindGUI {
    self.title = _beacon.identifier;
    self.nameLabel.text = _beacon.identifier;
    self.uuidLabel.text = _beacon.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"Major: %d", _beacon.major.intValue];
    self.minorLabel.text = [NSString stringWithFormat:@"Minor: %d", _beacon.minor.intValue];
}


#pragma mark - Notifications

- (void)didRangeBeaconNofitication:(NSNotification *)notif {
    CLBeacon *beacon = [notif.userInfo objectForKey:kDAiBeaconObjectKey];
    if ([beacon.proximityUUID isEqual:_beacon.proximityUUID]) {
        self.signalStrengthLabel.text = [NSString stringWithFormat:@"%ld db", (long)beacon.rssi];
    }
}


@end
