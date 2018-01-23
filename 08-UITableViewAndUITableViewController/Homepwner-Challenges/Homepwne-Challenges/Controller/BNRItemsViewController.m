//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Lieu Vu on 11/25/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()

@property (readwrite, strong, nonatomic) NSArray *sections;
@property (readwrite, assign, nonatomic) NSInteger priceThreshold;

@end

@implementation BNRItemsViewController

- (instancetype)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];

    if (self) {
        for (NSInteger i = 0; i < 70; i++) {
            [[BNRItemStore sharedStore] createItem];
        }

        _priceThreshold = 50;
        _sections = @[@"Items worth more than $50", @"The rest"];
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

    self.tableView.contentInset = UIEdgeInsetsMake([[UIApplication sharedApplication] statusBarFrame].size.height, 0, 0, 0);

    // Gold challenge - customizing the table
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];

    // Register cell class for reuse
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

    // Silver challenge - constant rows
    UITableViewCell *lastRow = [[UITableViewCell alloc] init];
    [lastRow.heightAnchor constraintEqualToConstant:44];
    lastRow.textLabel.text = @"No more items!";
    lastRow.textLabel.font = [UIFont systemFontOfSize:20];
    lastRow.backgroundColor = [UIColor clearColor];

    self.tableView.tableFooterView = lastRow;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;

    switch (section) {
        case 0:
            result = [[[BNRItemStore sharedStore] allItemsMoreThan:self.priceThreshold] count];
            break;

        case 1:
            result = [[[BNRItemStore sharedStore] allItemsLessThanOrEqual:self.priceThreshold] count];
            break;
    }

    return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // Bronze Challenge - sections
    return self.sections[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get a new or recycled cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];

    NSArray *items;
    BNRItem *item;

    switch (indexPath.section) {
        case 0:
            items = [[BNRItemStore sharedStore] allItemsMoreThan:self.priceThreshold];
            break;

        case 1:
            items = [[BNRItemStore sharedStore] allItemsLessThanOrEqual:self.priceThreshold];
            break;
    }

    item = items[indexPath.row];
    [cell.heightAnchor constraintEqualToConstant:60];
    cell.textLabel.text = [item description];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

@end
