//
//  BNRColorDescription.h
//  Colorboard
//
//  Created by Lieu Vu on 1/19/18.
//  Copyright © 2018 Lieu Vu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRColorDescription : NSObject

@property (readwrite, strong, nonatomic) UIColor *color;
@property (readwrite, copy, nonatomic) NSString *name;

@end
