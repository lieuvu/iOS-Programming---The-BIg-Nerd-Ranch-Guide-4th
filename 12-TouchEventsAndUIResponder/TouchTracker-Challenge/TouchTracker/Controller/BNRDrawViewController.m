//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Lieu Vu on 12/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

NSString * const BNRDrawingArchiveFile = @"drawing.archive";

@interface BNRDrawViewController ()

- (NSArray *)readDrawingArchive;

@end

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *drawnLines = [self readDrawingArchive];
    if (drawnLines.count && [self.view isKindOfClass:[BNRDrawView class]]) {
        [(BNRDrawView *)self.view drawLinesFromArray:drawnLines];
    }
}

- (void)archiveDrawings
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [path firstObject];
    NSString *drawingArchivePath = [documentsDir stringByAppendingPathComponent:BNRDrawingArchiveFile];
    NSArray *drawnLines = [(BNRDrawView *)self.view drawnLines];
    
    [NSKeyedArchiver archiveRootObject:drawnLines toFile:drawingArchivePath];
}

- (NSArray *)readDrawingArchive
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [path firstObject];
    NSString *drawingArchivePath = [documentsDir stringByAppendingPathComponent:BNRDrawingArchiveFile];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:drawingArchivePath];
}

@end
