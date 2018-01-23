//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Lieu Vu on 11/21/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHYpnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The largest circel will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size
                            .height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }
    
    // Configure line width to 10 points
    path.lineWidth = 10;
    
    // Configure the drawing color to light gray
    [[UIColor lightGrayColor] setStroke];
    
    // Draw the line!
    [path stroke];
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    /* image rectangle */
    CGRect imageRect = CGRectMake(bounds.size.width/4.0, bounds.size.height/4.0, bounds.size.width/2.0, bounds.size.height/2.0);
    
    {
        CGContextSaveGState(currentContext);
        // Gold challenge - part 2
        /* Draw triangle */
        UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
        [trianglePath moveToPoint:CGPointMake(center.x, imageRect.origin.y)];
        [trianglePath addLineToPoint:CGPointMake(imageRect.origin.x, imageRect.origin.y + imageRect.size.height * 1.05)];
        [trianglePath addLineToPoint:CGPointMake(imageRect.origin.x + imageRect.size.width * 1.05, imageRect.origin.y + imageRect.size.height * 1.05)];
        [trianglePath addLineToPoint:CGPointMake(center.x, imageRect.origin.y)];
        
        [trianglePath addClip];
        
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { 0.0, 1.0, 0.0, 1.0,   // Start color is green
                                  1.0, 1.0, 0.0, 1.0 }; // End color is yelow
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
        CGPoint startPoint = CGPointMake(center.x, imageRect.origin.y);
        CGPoint endPoint = CGPointMake(center.x, imageRect.origin.y + imageRect.size.height * 1.05);
        
        CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
        
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorSpace);
        
        CGContextRestoreGState(currentContext);
    }
    
    {
        CGContextSaveGState(currentContext);
        
        // Gold challenge - part 1
        CGContextSaveGState(currentContext);
        CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
        
        // Bronze challenge
        UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
        [logoImage drawInRect:imageRect];
        
        CGContextRestoreGState(currentContext);
    }
    
}

@end
