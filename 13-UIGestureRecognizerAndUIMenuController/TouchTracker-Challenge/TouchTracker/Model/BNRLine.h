//
//  BNRLine.h
//  TouchTracker
//
//  Created by Lieu Vu on 12/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface BNRLine : NSObject

@property (readwrite, assign, nonatomic) CGPoint begin;
@property (readwrite, assign, nonatomic) CGPoint end;
@property (readwrite, assign, nonatomic) CGFloat width;
@property (readwrite, strong, nonatomic) UIColor *color;

@end
