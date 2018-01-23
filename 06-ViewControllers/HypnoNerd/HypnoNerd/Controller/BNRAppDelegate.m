//
//  BNRAppDelegate.m
//  HypnoNerd
//
//  Created by Lieu Vu on 11/23/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import "BNRAppDelegate.h"
#import "BNRHypnosisViewController.h"
#import "BNRReminderViewController.h"

@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BNRHypnosisViewController *hvc = [[BNRHypnosisViewController alloc] init];
    BNRReminderViewController *rvc = [[BNRReminderViewController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[hvc, rvc];
    
    self.window.rootViewController = tabBarController;
    
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError *error) {
        if (!granted) {
            NSLog(@"The app can not peform notification");
        }
    }];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
