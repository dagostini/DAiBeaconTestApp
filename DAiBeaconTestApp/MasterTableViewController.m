//
//  MasterTableViewController.m
//  DAiBeaconTestApp
//
//  Created by Dejan on 06/07/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import "MasterTableViewController.h"
#import "AppDelegate.h"

#define kCellReuseID @"CellReuseID"

@interface MasterTableViewController () {
    NSMutableArray *_beacons;
    AppDelegate *_appDelegate;
}

@end


@implementation MasterTableViewController


#pragma mark - View Management

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createEditButton];
    [self createAddItemButton];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellReuseID];
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self loadData];
}

- (void)createEditButton {
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonAction)];
    self.navigationItem.leftBarButtonItem = editButton;
}

- (void)createAddItemButton {
    UIBarButtonItem *addItemBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItemAction)];
    self.navigationItem.rightBarButtonItem = addItemBarButton;
}

- (void)editButtonAction {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (void)addNewItemAction {
    NewItemViewController *newItemVC = [[NewItemViewController alloc] initWithDelegate:self];
    [self presentViewController:newItemVC animated:YES completion:nil];
}


#pragma mark - Data Management

- (void)loadData {
    NSData *beaconsData = [[NSUserDefaults standardUserDefaults] objectForKey:kDAiBeaconTestAppDataKey];
    _beacons = [NSKeyedUnarchiver unarchiveObjectWithData:beaconsData];
    if (!_beacons) {
        _beacons = [NSMutableArray new];
    }
    
    for (CLBeaconRegion *beacon in _beacons) {
        [_appDelegate startMonitoringRegion:beacon];
    }
    
    [self.tableView reloadData];
}

- (void)saveData {
    if (_beacons) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_beacons] forKey:kDAiBeaconTestAppDataKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


#pragma mark - AddNewItemDelegate

- (void)newItemViewController:(NewItemViewController *)newItemVC didCreateItem:(CLBeaconRegion *)beacon {
    [newItemVC dismissViewControllerAnimated:YES completion:^{
        if (beacon) {
            [_beacons insertObject:beacon atIndex:0];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            [self saveData];
            [_appDelegate startMonitoringRegion:beacon];
        }
    }];
}

- (void)newItemViewControllerDidCancel:(NewItemViewController *)newItemVC {
    [newItemVC dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _beacons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLBeaconRegion *currentItem = [_beacons objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseID forIndexPath:indexPath];
    cell.textLabel.text = currentItem.identifier;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete && _beacons.count > indexPath.row) {
        CLBeaconRegion *beacon = [_beacons objectAtIndex:indexPath.row];
        [_appDelegate stopMonitoringRegion:beacon];
        [_beacons removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self saveData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CLBeaconRegion *selectedItem = [_beacons objectAtIndex:indexPath.row];
    DetailViewController *detailsVC = [[DetailViewController alloc] initWithBeacon:selectedItem];
    [self.navigationController pushViewController:detailsVC animated:YES];
}


@end
