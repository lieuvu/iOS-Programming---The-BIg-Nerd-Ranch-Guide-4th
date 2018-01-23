//
//  BNRLine.h
//  TouchTracker
//
//  Created by Lieu Vu on 12/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface BNRLine : NSObject <NSCoding>

@property (readwrite, assign, nonatomic) CGPoint begin;
@property (readwrite, assign, nonatomic) CGPoint end;

@end
