//
//  main.m
//  RandomItems
//
//  Created by Lieu Vu on 11/20/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"
#import "BNRContainer.h"

int main(int argc, const char * argv[]) {
    
#if 0
    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        BNRItem *backPack = [[BNRItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backPack];
        
        BNRItem *calculator = [[BNRItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];
        
        backPack.containedItem = calculator;
        
        backPack = nil;
        calculator = nil;
        
        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }
        
        NSLog(@"Setting items to nil...");
        items = nil;
    }
    
#else
    @autoreleasepool {
        BNRItem *pen = [[BNRItem alloc] initWithItemName:@"pen" valueInDollar:5 serialNumber:@"A1"];
        BNRItem *eraser = [[BNRItem alloc] initWithItemName:@"eraser" valueInDollar:2 serialNumber:@"B2"];
        BNRItem *usb = [[BNRItem alloc] initWithItemName:@"usb" valueInDollar:23 serialNumber:@"C3"];
        BNRItem *ruler = [[BNRItem alloc] initWithItemName:@"ruler" valueInDollar:1 serialNumber:@"D4"];
        BNRContainer *box1 = [[BNRContainer alloc] initWithItemName:@"box1" valueInDollar:10 serialNumber:@"E51"];
        BNRContainer *box2 = [[BNRContainer alloc] initWithItemName:@"box2" valueInDollar:15 serialNumber:@"E52"];
        BNRContainer *bag = [[BNRContainer alloc] initWithItemName:@"bag" valueInDollar:20 serialNumber:@"F7"];
        
        [box1 setSubItems:@[pen, eraser]];
        [box2 setSubItems:@[usb, ruler]];
        [bag setSubItems:@[box1, box2]];
        
        NSLog(@"%@", bag);
    }
    
#endif

    return 0;
}
