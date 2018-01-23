//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Lieu Vu on 11/25/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (readonly, strong, nonatomic) NSArray *allItems;

+ (instancetype)sharedStore;

- (BNRItem *)createItem;
- (NSArray<BNRItem *> *)allItemsMoreThan:(NSInteger)value;
- (NSArray<BNRItem *> *)allItemsLessThanOrEqual:(NSInteger)value;

@end
