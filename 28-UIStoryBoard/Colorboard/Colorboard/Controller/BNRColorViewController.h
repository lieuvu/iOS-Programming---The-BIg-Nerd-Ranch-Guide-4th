//
//  BNRColorViewController.h
//  Colorboard
//
//  Created by Lieu Vu on 1/18/18.
//  Copyright © 2018 Lieu Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRColorDescription.h"

@interface BNRColorViewController : UIViewController

@property (readwrite, assign, nonatomic) BOOL existingColor;
@property (readwrite, strong, nonatomic) BNRColorDescription *colorDescription;

@end

