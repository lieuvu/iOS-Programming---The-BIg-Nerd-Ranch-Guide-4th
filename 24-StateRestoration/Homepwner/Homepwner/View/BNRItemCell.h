//
//  BNRItemCell.h
//  Homepwner
//
//  Created by Lieu Vu on 12/7/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRItemCell : UITableViewCell

@property (readwrite, weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (readwrite, weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightContraint;
@property (readwrite, copy, nonatomic) void (^actionBlock)(void);

@end
