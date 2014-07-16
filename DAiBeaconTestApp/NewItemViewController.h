//
//  NewItemViewController.h
//  DAiBeaconTestApp
//
//  Created by Dejan on 06/07/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLBeaconRegion.h>

@class NewItemViewController;

@protocol AddNewItemDelegate <NSObject>

- (void)newItemViewController:(NewItemViewController *)newItemVC didCreateItem:(CLBeaconRegion *)beacon;
- (void)newItemViewControllerDidCancel:(NewItemViewController *)newItemVC;

@end


@interface NewItemViewController : UIViewController

- (id)initWithDelegate:(id<AddNewItemDelegate>)delegate;

@end
