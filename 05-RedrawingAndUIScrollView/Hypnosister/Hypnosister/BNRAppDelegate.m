//
//  BNRAppDelegate.m
//  Hypnosister
//
//  Created by Lieu Vu on 11/21/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRHypnosisView.h"

@interface BNRAppDelegate()<UIScrollViewDelegate>

@property (readwrite, strong, nonatomic) BNRHypnosisView *hypnosisView;

@end

@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    UIViewController *controller = [[UIViewController alloc] init];
    self.window.rootViewController = controller;
    
    {
//        // Create CGRects for frames
//        CGRect screenRect = self.window.bounds;
//        CGRect bigRect = screenRect;
//        bigRect.size.width *= 2.0;
//        bigRect.size.height *= 2.0;
//
//        // Create a screen-sized scroll view and add it to the root controller
//        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
//        [controller.view addSubview:scrollView];
//
//        // Create a super-sized hypnosis view and add it to the scroll view
//        BNRHypnosisView *hypnosisView = [[BNRHypnosisView alloc] initWithFrame:bigRect];
//        [scrollView addSubview:hypnosisView];
//
//        // Tell the scroll view ho big its content area is
//        scrollView.contentSize = bigRect.size;
    }
    
    {
        // Create CGRects for frames
        CGRect screenRect = self.window.bounds;
        CGRect bigRect = screenRect;
        bigRect.size.width *= 2.0;
        
        // Create a screen-sized scroll view and add it to the root controller
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
        scrollView.delegate = self;
        
//        scrollView.pagingEnabled = YES; /* paging enabled */
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 5.0;
        
        [controller.view addSubview:scrollView];
        
        // Create a super-sized hypnosis view and add it to the scroll view
        self.hypnosisView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
        [scrollView addSubview:self.hypnosisView];
        
        // Add another screen-sized hypnosis view just off screen to the right
        screenRect.origin.x += screenRect.size.width;
//        BNRHypnosisView *anotherView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
//        [scrollView addSubview:anotherView];
        
        // Tell the scroll view how big its content area is
        scrollView.contentSize = bigRect.size;
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
}

@end
