//
//  BNRItem.h
//  Homepwner
//
//  Created by Lieu Vu on 12/13/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UIImage;

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem : NSManagedObject

@property (readwrite, copy, nonatomic) NSString *itemName;
@property (readwrite, copy, nonatomic) NSString *serialNumber;
@property (readwrite, assign, nonatomic) int32_t valueInDollars;
@property (readwrite, copy, nonatomic) NSDate *dateCreated;
@property (readwrite, copy, nonatomic) NSString *itemKey;
@property (readwrite, strong, nonatomic) UIImage *thumbnail;
@property (readwrite, assign, nonatomic) double orderingValue;
@property (readwrite, strong, nonatomic) NSManagedObject *assetType;

- (void)setThumbnailFromImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
