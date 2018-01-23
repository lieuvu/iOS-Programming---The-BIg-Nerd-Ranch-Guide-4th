//
//  BNRContainer.h
//  RandomItems
//
//  Created by Lieu Vu on 11/20/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

@interface BNRContainer : BNRItem

@property (strong, nonatomic) NSArray *subItems;

- (void)setSubItems:(NSArray *)subItems;
- (NSArray *)subItems;

@end
