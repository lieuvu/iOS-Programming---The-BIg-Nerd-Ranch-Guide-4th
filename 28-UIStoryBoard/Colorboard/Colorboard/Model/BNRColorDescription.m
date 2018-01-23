//
//  BNRColorDescription.m
//  Colorboard
//
//  Created by Lieu Vu on 1/19/18.
//  Copyright © 2018 Lieu Vu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BNRColorDescription.h"

@implementation BNRColorDescription

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _color = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        _name = @"Blue";
    }
    
    return self;
}

@end
