//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Lieu Vu on 11/29/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController

@property (readwrite, strong, nonatomic) BNRItem *item;

@end
