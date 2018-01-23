//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Lieu Vu on 11/29/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

@property (readwrite, strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *constraintsOfSafeArea;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *nameField;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *valueField;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (readwrite, weak, nonatomic) IBOutlet UIButton *changeDateButton;

@end

@implementation BNRDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Autolayout for iOS before 11
    if ([[[UIDevice currentDevice] systemVersion] compare:@"11" options:NSNumericSearch] == NSOrderedAscending) {
        /* Remove constraints of safe area available only on iOS 11 */
        [self.view removeConstraints:self.constraintsOfSafeArea];
        
        /* Constraints for iOS before 11 */
        [[self.nameLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16] setActive:YES];
        [[self.nameField.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:32] setActive:YES];
        [[self.view.trailingAnchor constraintEqualToAnchor:self.nameField.trailingAnchor constant:16] setActive:YES];
        [[self.changeDateButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // You need an NSDate Formatter taht will turn a date into a simple date string
    static NSDateFormatter *dateFormatter = nil;
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

@end
