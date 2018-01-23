//
//  BNRDateViewController.m
//  Homepwner
//
//  Created by Lieu Vu on 11/30/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRDateViewController.h"
#import "BNRItem.h"

@interface BNRDateViewController ()

@property (readwrite, strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *constraintsOfSafeArea;
@property (readwrite, weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRDateViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.navigationItem.title = @"Date Selection";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Autolayout for iOS before 11
    if ([[[UIDevice currentDevice] systemVersion] compare:@"11" options:NSNumericSearch] == NSOrderedAscending) {
        /* Remove constraints of safe area available only on iOS 11 */
        [self.view removeConstraints:self.constraintsOfSafeArea];
        
        /* Constraints for iOS before 11 */
        [[self.datePicker.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:32] setActive:YES];
        [[self.datePicker.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
        [[self.view.trailingAnchor constraintEqualToAnchor:self.datePicker.trailingAnchor] setActive:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.datePicker.date = self.item.dateCreated;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.item.dateCreated = self.datePicker.date;
}

@end
