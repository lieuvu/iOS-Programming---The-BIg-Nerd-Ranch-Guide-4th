//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Lieu Vu on 12/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}


@end
