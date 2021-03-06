//
//  BNRAssetTypeViewController.m
//  Homepwner
//
//  Created by Lieu Vu on 12/13/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRAssetTypeViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRAssetTypeViewController ()

@end

@implementation BNRAssetTypeViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.navigationItem.title = NSLocalizedString(@"Asset Type", @"BNRAssetTypeViewController title");
    }
    
    return self;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}
#pragma GCC diagnostic pop

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allAssetTypes] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
    NSManagedObject *assetType = allAssets[indexPath.row];
    
    // Use key-value coding to get asset type's label
    NSString *assetTypeKey = [assetType valueForKey:@"label"];
    NSString *assetLabel = NSLocalizedString(assetTypeKey, nil);
    cell.textLabel.text = assetLabel;
    
    // Checkmark the one that is currentl selected
    if (assetType == self.item.assetType) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
    NSManagedObject *assetType = allAssets[indexPath.row];
    self.item.assetType = assetType;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
