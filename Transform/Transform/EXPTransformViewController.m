//
//  EXPTransformViewController.m
//  Transform
//
//  Created by user1 on 12/09/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EXPTransformViewController.h"

@interface EXPTransformViewController () {
    UIView *transformView1;
}
@end

@implementation EXPTransformViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    transformView1 = [[UIView alloc] init];
    transformView1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1f];
    transformView1.frame = CGRectMake(110.0f, 180.0f, 100, 100);
    [self.view addSubview:transformView1];
    
}

- (void)viewDidUnload
{
    durationSlider = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)reset:(id)sender {
    [UIView animateWithDuration:durationSlider.value animations:^{
        transformView1.transform = CGAffineTransformIdentity;
        transformView1.frame = CGRectMake(110.0f, 180.0f, 100, 100);
    }];
}

- (IBAction)exp1:(id)sender {
    [UIView animateWithDuration:durationSlider.value animations:^{
        transformView1.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    }];
}

- (IBAction)exp2:(id)sender {
    [UIView animateWithDuration:durationSlider.value animations:^{
        transformView1.transform = CGAffineTransformIdentity;
    }];
}

- (IBAction)exp3:(id)sender {
    [UIView animateWithDuration:durationSlider.value animations:^{
        CGRect frame = transformView1.frame;
        frame.size.width = 200;
        frame.size.height = 50;
        transformView1.frame = frame;
    }];
}

@end
