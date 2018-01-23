//
//  BNRImageTransformer.m
//  Homepwner
//
//  Created by Lieu Vu on 12/13/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRImageTransformer.h"

@implementation BNRImageTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
