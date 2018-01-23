//
//  BNRLine.m
//  TouchTracker
//
//  Created by Lieu Vu on 12/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRLine.h"

static NSString * const BNRLineBeginKey = @"BNRLineBegin";
static NSString * const BNRLineEndKey = @"BNRLineEnd";

@implementation BNRLine

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.begin = [aDecoder decodeCGPointForKey:BNRLineBeginKey];
    self.end = [aDecoder decodeCGPointForKey:BNRLineEndKey];
   
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeCGPoint:self.begin forKey:BNRLineBeginKey];
    [aCoder encodeCGPoint:self.end forKey:BNRLineEndKey];
}

@end
