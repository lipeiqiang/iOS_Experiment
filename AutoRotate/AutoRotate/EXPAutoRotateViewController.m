//
//  EXPAutoRotateViewController.m
//  AutoRotate
//
//  Created by user1 on 12/09/27.
//  Copyright (c) 2012年 jiroiwas. All rights reserved.
//

#import "EXPAutoRotateViewController.h"

@interface EXPAutoRotateViewController ()

@end

@implementation EXPAutoRotateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return [[_switches objectAtIndex:0] isOn];
}

- (BOOL)shouldAutorotate
{
    return [[_switches objectAtIndex:1] isOn];
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[_switches objectAtIndex:2] isOn]) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
