//
//  BNRHypnosis.m
//  HypnoNerd
//
//  Created by Lieu Vu on 11/23/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>
@end

@implementation BNRHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {

        // Set the tab bar item's title
        self.tabBarItem.title = @"Hypnosis";

        // Create a UIImage from a file
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];

        // Put that image on the tab bar item
        self.tabBarItem.image = i;
    }

    return self;
}

- (void)loadView
{
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];

    self.view = backgroundView;

    UITextField *textField = [[UITextField alloc] init];

    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;

    /* Set delegate of text field */
    textField.delegate = self;

    [backgroundView addSubview:textField];

    /* Layout text field on main view of the controller */
    [[textField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    if (@available(iOS 11, *)) {
        [[textField.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:[[UIApplication sharedApplication] statusBarFrame].size.height] setActive:YES];
    } else {
        [[textField.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:[[UIApplication sharedApplication] statusBarFrame].size.height] setActive:YES];
    }
    [[textField.heightAnchor constraintEqualToConstant:30] setActive:YES];
    [[textField.widthAnchor constraintEqualToConstant:240] setActive:YES];
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (NSInteger i = 0; i < 20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];

        // Configure the label's colors and text
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.text = message;

        // This method resizes the label, which will be relative to the text
        // that it is displaying
        [messageLabel sizeToFit];

        // Get a random x value that fits within the hypnosis view's width
        NSInteger width = (NSInteger)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        NSInteger x = arc4random() % width;

        // Get a random y value that fits within the hypnosis view's height
        NSInteger height = (NSInteger)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        NSInteger y = arc4random() % height;

        // Update the label's frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;

        // Add the label to the hierarchy
        [self.view addSubview:messageLabel];

        UIInterpolatingMotionEffect *motionEffect;

        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];

        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];

    textField.text = @"";
    [textField resignFirstResponder];

    return YES;
}

@end
