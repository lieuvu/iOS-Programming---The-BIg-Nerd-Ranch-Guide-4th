//
//  BNRImageViewController.h
//  Homepwner
//
//  Created by Lieu Vu on 12/8/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRImageViewController : UIViewController <UIPopoverPresentationControllerDelegate>

@property (readwrite, strong, nonatomic) UIImage *image;

@end
