//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Lieu Vu on 12/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawingColorViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad
{
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    swipeUp.numberOfTouchesRequired = 3;
    [self.view addGestureRecognizer:swipeUp];
}


- (void)swipeUp:(UISwipeGestureRecognizer *)gr
{
    NSLog(@"Swipe up");
    
    BNRDrawingColorViewController *drawingColorVC = [[BNRDrawingColorViewController alloc] initWithNibName:@"BNRDrawingColorViewController" bundle:nil];
    CGRect drawingColorViewFrame = drawingColorVC.view.frame;
    drawingColorViewFrame.size.height = self.view.frame.size.height * 0.5;
    drawingColorVC.view.frame = drawingColorViewFrame;
    
    if ([self.view isKindOfClass:[BNRDrawView class]]) {
        drawingColorVC.drawView = (BNRDrawView *)self.view;
    }
    
//    self.modalPresentationStyle = UIModalPresentationPageSheet;
    drawingColorVC.modalPresentationStyle = UIModalPresentationPageSheet;
    
    [self presentViewController:drawingColorVC animated:YES completion:nil];
}

@end
