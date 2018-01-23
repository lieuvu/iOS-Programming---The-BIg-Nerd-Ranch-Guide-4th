//
//  BNRDrawingColorViewController.m
//  TouchTracker-Challenge
//
//  Created by Lieu Vu on 12/4/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawingColorViewController.h"
#import "BNRDrawView.h"

@interface BNRDrawingColorViewController ()

@end

@implementation BNRDrawingColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//
//    CGRect drawingColorViewFrame = self.view.frame;
//    drawingColorViewFrame.size.height = drawingColorViewFrame.size.height * 0.5;
//    self.view.frame = drawingColorViewFrame;
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    CGRect drawingColorViewFrame = self.view.bounds;
//    drawingColorViewFrame.size.height = drawingColorViewFrame.size.height * 0.5;
//    self.view.frame = drawingColorViewFrame;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectColor:(UIView *)selectedColor
{
    if (self.drawView) {
        self.drawView.lineColor = selectedColor.backgroundColor;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
