//
//  BNRPaletteViewController.m
//  Colorboard
//
//  Created by Lieu Vu on 1/19/18.
//  Copyright © 2018 Lieu Vu. All rights reserved.
//

#import "BNRPaletteViewController.h"
#import "BNRColorViewController.h"
#import "BNRColorDescription.h"

@interface BNRPaletteViewController ()

@property (readwrite, strong, nonatomic) NSMutableArray *colors;

@end

@implementation BNRPaletteViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Others

- (NSMutableArray *)colors
{
    if (!_colors) {
        _colors = [[NSMutableArray alloc] init];
        
        BNRColorDescription *colorDes = [[BNRColorDescription alloc] init];
        [_colors addObject:colorDes];
    }
    
    return _colors;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colors.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    BNRColorDescription *colorDes = self.colors[indexPath.row];
    cell.textLabel.text = colorDes.name;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewColor"]) {
        
        // If we are adding a new color, create and instance
        // and add it to the colors array
        BNRColorDescription *colorDes = [[BNRColorDescription alloc] init];
        [self.colors addObject:colorDes];
        
        // Then use the segue to set the color on the view controller
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        BNRColorViewController *colorViewController = (BNRColorViewController *)[navigationController topViewController];
        colorViewController.colorDescription = colorDes;
        colorViewController.existingColor = NO;
        
    } else if ([segue.identifier isEqualToString:@"ExistingColor"]) {
        
        // For the show segue, the sender is the UITableViewCell
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        BNRColorDescription *colorDes = self.colors[indexPath.row];
        
        // Set the color, and also tell the view controller that this is an
        // existing color
        BNRColorViewController *colorViewController = (BNRColorViewController *)segue.destinationViewController;
        colorViewController.colorDescription = colorDes;
        colorViewController.existingColor = YES;
    }
}

@end
