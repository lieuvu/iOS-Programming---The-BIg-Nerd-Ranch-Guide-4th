//
//  BNRHypnosis.m
//  HypnoNerd
//
//  Created by Lieu Vu on 11/23/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@implementation BNRHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {

        // Set the tab bar item's title
        self.tabBarItem.title = @"Hypnosis";

        // Create a UIImage from a file
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];

        // Put that image on the tab bar item
        self.tabBarItem.image = i;
    }

    return self;
}

- (void)loadView
{
    // Create a view
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];

    // Set it as *the* view of this view controller
    self.view = backgroundView;

    /* Silver challenge - Add UISegmentedControl */
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Red", @"Green", @"Blue"]];
    segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    segmentedControl.layer.cornerRadius = 5.0;
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.tintColor = [UIColor brownColor];

    [segmentedControl addTarget:self action:@selector(changeSegmentedControlIndex:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:segmentedControl];

    [[segmentedControl.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[segmentedControl.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:[[UIApplication sharedApplication] statusBarFrame].size.height] setActive:YES];
}

- (void)viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];

    NSLog(@"BNRHypnosisViewController loaded its view");
}

- (void)changeSegmentedControlIndex:(UISegmentedControl *)segmentedControl
{
    NSArray *colors = @[ [UIColor redColor],
                         [UIColor greenColor],
                         [UIColor blueColor] ];

    [(BNRHypnosisView *)self.view paintCircleColor:colors[segmentedControl.selectedSegmentIndex]];
}

@end
