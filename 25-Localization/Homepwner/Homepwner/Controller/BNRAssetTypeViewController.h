//
//  BNRAssetTypeViewController.h
//  Homepwner
//
//  Created by Lieu Vu on 12/13/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRAssetTypeViewController : UITableViewController <UIViewControllerRestoration>

@property (readwrite, strong,nonatomic) BNRItem *item;

@end
