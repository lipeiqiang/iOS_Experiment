//
//  EXPMemoySimViewController.m
//  Icon
//
//  Created by user1 on 12/11/26.
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

- (IBAction)allocAction:(id)sender {
}

- (IBAction)freeAction:(id)sender {
}
- (void)dealloc {
    [_freeAction release];
    [_freeSizeLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setFreeSizeLabel:nil];
    [super viewDidUnload];
}
@end
