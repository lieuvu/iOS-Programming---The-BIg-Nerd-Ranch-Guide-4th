//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Lieu Vu on 12/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView () <UIGestureRecognizerDelegate>

@property (readwrite, strong, nonatomic) NSMutableDictionary *linesInProgress;
@property (readwrite, strong, nonatomic) NSMutableArray *finishedLines;
@property (readwrite, weak, nonatomic) BNRLine *selectedLine;
@property (readwrite, strong, nonatomic) UIPanGestureRecognizer *moveRecognizer;
@property (readwrite, strong, nonatomic) UIPanGestureRecognizer *drawingVelocityRecognizer;

@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.selectedLine = nil;
        self.lineColor = [UIColor blackColor];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];
        
         UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        
        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
        
        // Gold challenge - speed and size
        self.drawingVelocityRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changeLineWidth:)];
        self.drawingVelocityRecognizer.maximumNumberOfTouches = 2;
        self.drawingVelocityRecognizer.delegate = self;
        self.drawingVelocityRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.drawingVelocityRecognizer];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Draw finished lines according to its color
    for (BNRLine *line in self.finishedLines) {
        [self strokeLine:line withWidth:line.width color:line.color];
    }
    
    for (NSValue *key in self.linesInProgress) {
        BNRLine *line = self.linesInProgress[key];
       [self strokeLine:line withWidth:line.width color:line.color];
    }
    
    if (self.selectedLine) {
        [self strokeLine:self.selectedLine withWidth:self.selectedLine.width color:[UIColor greenColor]];
    }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        line.width = 5.0;
        line.color = self.lineColor;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        line.end = [t locationInView:self];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - UIGestureRecognizer

- (void)doubleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Double Tap");
    
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Tap");
    
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self linetAtPoint:point];
    
    if (self.selectedLine) {
        
        // Make ourselves the target of menu item action messages
        [self becomeFirstResponder];
        
        // Grab the menu controller
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        // Create a new "Delete" UIMenuItem
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        
        // Tell the menu wher it should come from and show it
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    } else {
        // Hide the menu if no line is selected
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }
    
    [self setNeedsDisplay];
}

- (void)longPress:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan) {
        
        if ([UIMenuController sharedMenuController].isMenuVisible) {
            [UIMenuController sharedMenuController].menuVisible = NO;
        }
        
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self linetAtPoint:point];
        
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        self.selectedLine = nil;
    }
    
    [self setNeedsDisplay];
}

- (void)moveLine:(UIPanGestureRecognizer *)gr
{
    NSLog(@"Recognized moveLine");
    
    // If we have not selected a line, we do not do anything here
    if (!self.selectedLine) {
        return;
    }
    
    // When the pan recognizer changes its position...
    // Silver challenge - mysterious lines
    if (gr.state == UIGestureRecognizerStateChanged &&
        [UIMenuController sharedMenuController].isMenuVisible == NO) {
        // How far has the pan moved?
        CGPoint translation = [gr translationInView:self];
        
        // Add the tranlation to the current beginning and end points of the line
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        // Set the new beginning and end points of the line
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        
        // Redraw screen
        [self setNeedsDisplay];
        
        // Reset translation to the latest update
        [gr setTranslation:CGPointZero inView:self];
    }
}

- (void)changeLineWidth:(UIPanGestureRecognizer *)gr
{
    NSLog(@"Recognized changeLineWidth");
    
    if (gr.state == UIGestureRecognizerStateChanged &&
        [UIMenuController sharedMenuController].isMenuVisible == NO) {
        // How fast has the pan moved?
        CGPoint velocity = [gr velocityInView:self];
        
        NSLog(@"velocity: %@", NSStringFromCGPoint(velocity));
        
        [self.linesInProgress enumerateKeysAndObjectsUsingBlock:^(id key, BNRLine *drawingLine, BOOL *stop) {
            CGFloat lineWidth = sqrt(fabs(velocity.x) + fabs(velocity.y));
            drawingLine.width = (lineWidth == 0) ? 1.0 : lineWidth;
        }];
        
        // Redraw screen
        [self setNeedsDisplay];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
   if (gestureRecognizer == self.moveRecognizer || gestureRecognizer == self.drawingVelocityRecognizer) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Others

- (void)strokeLine:(BNRLine *)line withWidth:(CGFloat)lineWidth color:(UIColor *)color
{
    [color set];
    UIBezierPath *bp = [[UIBezierPath alloc] init];
    bp.lineWidth = lineWidth;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)deleteLine:(id)sender
{
    // Remove the selected line from the list of _finishedLines
    [self.finishedLines removeObject:self.selectedLine];
    
    // Redraw everything
    [self setNeedsDisplay];
}

- (BNRLine *)linetAtPoint:(CGPoint)p
{
    // Fina lne close to p
    for (BNRLine *l in self.finishedLines) {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        
        // Check a few points on the line
        for (CGFloat t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            
            // If the tapped point is within 20 points, let's return this line
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return l;
            }
        }
    }
    
    // If nothing is close enough to the tapped point,
    // then we did not select a line
    return nil;
}

@end
