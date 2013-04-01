//
//  EXPContainerChildViewController.m
//  Container
//
//  Created by ブックライブ on 2013/03/29.
//  Copyright (c) 2013年 BookLive. All rights reserved.
//

#import "EXPContainerChildViewController.h"

static NSUInteger _sequentialPageNo = 0;

@interface EXPContainerChildViewController ()

@end

@implementation EXPContainerChildViewController {
    NSUInteger _pageNo;
}

- (id)init
{
    self = [super init];
    if (self) {
        _pageNo = _sequentialPageNo++;
    }
    return self;
}

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
    
    CGRect baseBounds = self.view.bounds;
    CGRect labelFrame = baseBounds;
    labelFrame.origin.x = 20;
    labelFrame.origin.y = 20;
    labelFrame.size.width = baseBounds.size.width - 40;
    labelFrame.size.height = baseBounds.size.height - 40;
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.text = [NSString stringWithFormat:@"%d", _pageNo];
    
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
