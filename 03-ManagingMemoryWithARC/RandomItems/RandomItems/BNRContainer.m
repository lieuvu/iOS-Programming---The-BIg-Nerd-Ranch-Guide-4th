//
//  BNRContainer.m
//  RandomItems
//
//  Created by Lieu Vu on 11/20/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer

- (int)valueInDollars
{
    //NSLog(@"17: %@, value: %d", self.itemName, _valueInDollars);
    int totalValueInDollars = super.valueInDollars;
    
    for (BNRItem *item in self.subItems) {
        totalValueInDollars += item.valueInDollars;
    }
    
    return totalValueInDollars;
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
