//
//  BNRAppDelegate.m
//  TouchTracker
//
//  Created by Lieu Vu on 12/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRDrawViewController.h"

@interface BNRAppDelegate ()

@end

@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BNRDrawViewController *dvc = [[BNRDrawViewController alloc] init];
    self.window.rootViewController = dvc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
