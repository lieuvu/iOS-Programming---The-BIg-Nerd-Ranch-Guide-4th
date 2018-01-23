//
//  BNRContainer.m
//  RandomItems
//
//  Created by Lieu Vu on 11/20/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer

- (void)setSubItems:(NSArray *)subItems
{
    _subItems = subItems;
}

- (NSArray *)subItems
{
    return _subItems;
}

- (int)valueInDollars
{
    int totalValueOfSubItemsInDollars = 0;
    for (BNRItem *item in self.subItems) {
        totalValueOfSubItemsInDollars += item.valueInDollars;
    }
    
    return _valueInDollars + totalValueOfSubItemsInDollars;
}

- (NSString *)description
{
    NSMutableString *descriptionString = [[NSMutableString alloc] init];
    
    [descriptionString appendFormat:@"%@ (%@): has total value of %d, recored on %@.", self.itemName, self.serialNumber, self.valueInDollars, self.dateCreated];
    
    [descriptionString appendString:@", containing {\n"];
    for (BNRItem *subItem in self.subItems) {
        [descriptionString appendFormat:@"%@\n", subItem];
    }
    [descriptionString appendString:@"}"];
    
    return descriptionString;
}

@end
