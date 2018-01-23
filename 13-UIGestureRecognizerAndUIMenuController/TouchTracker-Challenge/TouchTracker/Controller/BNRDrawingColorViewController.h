//
//  BNRDrawingColorViewController.h
//  TouchTracker-Challenge
//
//  Created by Lieu Vu on 12/4/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRDrawView;

@interface BNRDrawingColorViewController : UIViewController

@property (readwrite, weak, nonatomic) BNRDrawView *drawView;

@end
