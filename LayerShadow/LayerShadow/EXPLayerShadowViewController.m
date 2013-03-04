//
//  EXPLayerShadowViewController.m
//  LayerShadow
//
//  Created by user1 on 12/09/06.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define kLayerAnimationDuration 1.0f;

#import "EXPLayerShadowViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface EXPLayerShadowViewController ()

@end

@implementation EXPLayerShadowViewController {
    UIView *expView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    expView = [[UIView alloc] init];
    [self.view addSubview:expView];
    
    expView.layer.shadowOpacity = 0.5f;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self reset];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)expAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self reset];
            break;
        case 1:
            [self zoomIn];
            break;
        case 2:
            [self zoomOut];
            break;
            
            
        default:
            break;
    }
    
}

- (void)reset
{
    expView.frame = CGRectMake(0, 0, 100, 100);
    expView.center = self.view.center;
    expView.backgroundColor = [UIColor whiteColor];
    expView.layer.shadowPath = [UIBezierPath bezierPathWithRect:expView.layer.bounds].CGPath;
}

- (void)zoomIn
{
    
    CGRect frame = expView.frame;
    frame.size.width *= 1.2f;
    frame.size.height *= 1.2f;
    expView.frame = frame;
    [self adjustShadow];
    
}

- (void)zoomOut
{
    CGRect frame = expView.frame;
    frame.size.width *= 0.8f;
    frame.size.height *= 0.8f;
    expView.frame = frame;
    [self adjustShadow];
    
}

- (void)adjustShadow
{

    CABasicAnimation *shadowAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
    shadowAnimation.removedOnCompletion = NO;
    shadowAnimation.fillMode = kCAFillModeForwards;
    shadowAnimation.toValue = (id)[UIBezierPath bezierPathWithRect:expView.bounds].CGPath;
    [expView.layer addAnimation:shadowAnimation forKey:@"shadowPath"];   
}







@end
