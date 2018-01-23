//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by Lieu Vu on 11/23/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()

@property (readwrite, weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Get the tab bar item
        UITabBarItem *tbi = self.tabBarItem;
        
        // Give it a label
        tbi.title = @"Reminder";
        
        // Give it an image
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        tbi.image = i;
    }
    
    return self;
}

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
    
    UNMutableNotificationContent *reminderContent = [[UNMutableNotificationContent alloc] init];
    reminderContent.body = @"Hypnotize me!";
    reminderContent.sound = [UNNotificationSound defaultSound];
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    
    UNCalendarNotificationTrigger *reminderTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:YES];
    
    UNNotificationRequest *reminderRequest = [UNNotificationRequest requestWithIdentifier:@"BNRReminderNotification" content:reminderContent trigger:reminderTrigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:reminderRequest withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Notification error: %@", error);
        }
    }];
}

- (void)viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"BNRReminderViewController loaded its view");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

@end
