//
//  EXPContainerChildViewController.m
//  Container
//
//  Created by ブックライブ on 2013/03/29.
//  Copyright (c) 2013年 BookLive. All rights reserved.
//

#import "EXPContainerChildViewController.h"

@interface EXPContainerChildViewController ()

@end

@implementation EXPContainerChildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"prev" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        button.frame = CGRectMake(10, 10, 73, 44);
        [button addTarget:self action:@selector(prevButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"next" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        button.frame = CGRectMake(100,10,73,44);
        [button addTarget:self action:@selector(nextButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"remove" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        button.frame = CGRectMake(200,10,73,44);
        [button addTarget:self action:@selector(removeFromParentViewController) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
}

- (IBAction)nextButtonDidTapped:(id)sender {
    if ([self.parentViewController conformsToProtocol:@protocol(EXPContainerPageController)]) {
        [self.parentViewController performSelector:@selector(moveToNextChildView)];
    }
}

- (IBAction)prevButtonDidTapped:(id)sender {
    if ([self.parentViewController conformsToProtocol:@protocol(EXPContainerPageController)]) {
        [self.parentViewController performSelector:@selector(moveToPrevChildView)];
    }
}

@end
