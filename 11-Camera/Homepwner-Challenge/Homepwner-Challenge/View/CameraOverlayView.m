//
//  CameraOverlayView.m
//  Homepwner-Challenge
//
//  Created by Lieu Vu on 11/30/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "CameraOverlayView.h"

static const CGFloat StrokeLineWidth = 2.0f;

@interface CameraOverlayView ()

@property (readwrite, strong, nonatomic) UIColor *overlayColor;

@end

@implementation CameraOverlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.overlayColor = [UIColor grayColor];
    }
    
    return self;
}

// Draw a set of crosshair and circle in the middle of the image capture area
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = [self bounds];
    
    // Find the center of the view
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // Radius of crosshair
    float radiusOfCrosshair = hypot(bounds.size.width, bounds.size.height) / 8;
    
    [self.overlayColor setStroke];
    
    // Draw a circle
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    [circlePath addArcWithCenter:center radius:radiusOfCrosshair startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    circlePath.lineWidth = StrokeLineWidth / [[UIScreen mainScreen] scale];
    [circlePath stroke];
    
    // Draw a crosshair
    UIBezierPath *crossHairPath = [[UIBezierPath alloc] init];
    /* Horizontal line */
    [crossHairPath moveToPoint:CGPointMake(center.x + radiusOfCrosshair, center.y)];
    [crossHairPath addLineToPoint:CGPointMake(center.x - radiusOfCrosshair, center.y)];
    /* Vertical line */
    [crossHairPath moveToPoint:CGPointMake(center.x, center.y + radiusOfCrosshair)];
    [crossHairPath addLineToPoint:CGPointMake(center.x, center.y - radiusOfCrosshair)];
    crossHairPath.lineWidth = StrokeLineWidth / [[UIScreen mainScreen] scale];
    [crossHairPath stroke];
}

@end
