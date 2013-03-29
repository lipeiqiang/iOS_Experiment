//
//  EXPPageBasedDataViewController.m
//  PageBased
//
//  Created by ブックライブ on 2013/03/29.
//  Copyright (c) 2013年 BookLive. All rights reserved.
//

#import "EXPPageBasedDataViewController.h"

@interface EXPPageBasedDataViewController ()

@end

@implementation EXPPageBasedDataViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

@end
