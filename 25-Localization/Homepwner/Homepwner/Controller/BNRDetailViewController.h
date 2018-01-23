//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Lieu Vu on 11/29/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController <UIViewControllerRestoration>

@property (readwrite, strong, nonatomic) BNRItem *item;
@property (readwrite, strong, nonatomic) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;

@end
