//
//  EXPMemoySimViewController.m
//  iPhoneOnly
//
//  Created by user1 on 12/11/27.
//  Copyright (c) 2012年 jiroiwas. All rights reserved.
//

#import "EXPMemoySimViewController.h"

@interface EXPMemoySimViewController ()

@end

@implementation EXPMemoySimViewController

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

- (void)dealloc {
    [_sizeLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSizeLabel:nil];
    [super viewDidUnload];
}
@end
