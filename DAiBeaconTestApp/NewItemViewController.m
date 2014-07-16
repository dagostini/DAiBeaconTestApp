//
//  NewItemViewController.m
//  DAiBeaconTestApp
//
//  Created by Dejan on 06/07/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import "NewItemViewController.h"

@interface NewItemViewController ()

@property(unsafe_unretained, nonatomic) id<AddNewItemDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *uuid;
@property (weak, nonatomic) IBOutlet UITextField *major;
@property (weak, nonatomic) IBOutlet UITextField *minor;

@end


@implementation NewItemViewController


#pragma mark - Initialization

- (id)initWithDelegate:(id<AddNewItemDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}


#pragma mark - User Actions

- (IBAction)cancelAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(newItemViewControllerDidCancel:)]) {
        [self.delegate newItemViewControllerDidCancel:self];
    }
}

- (IBAction)doneAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(newItemViewController:didCreateItem:)]) {
        [self.delegate newItemViewController:self didCreateItem:[[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:self.uuid.text]
                                                                                                        major:self.major.text.intValue
                                                                                                        minor:self.minor.text.intValue
                                                                                                   identifier:self.name.text]];
    }
}


@end
