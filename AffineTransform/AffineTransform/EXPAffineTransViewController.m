//
//  EXPAffineTransViewController.m
//  AffineTransform
//
//  Created by user1 on 12/09/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "EXPAffineTransViewController.h"

@interface EXPAffineTransViewController () {
    UIView *expView;
}

@end

@implementation EXPAffineTransViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    expView = [[UIView alloc] initWithFrame:CGRectMake(110, 65, 100, 100)];
    expView.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"kami"];
    expView.layer.contents = (id)image.CGImage;
    [self.view insertSubview:expView atIndex:0];
    
    NSUInteger index = 0;
    for (UISlider *slider in sliders) {
        slider.minimumValue = - 5.0f;
        slider.maximumValue = 5.0f;
        [(UILabel *)[labels objectAtIndex:index++] setText:[NSString stringWithFormat:@"%.2f", slider.value]];
    }
    UISlider *txSlider = [sliders objectAtIndex:4];
    txSlider.minimumValue *= 10.0f;
    txSlider.maximumValue *= 10.0f;
    
    UISlider *tySlider = [sliders objectAtIndex:5];
    tySlider.minimumValue *= 10.0f;
    tySlider.maximumValue *= 10.0f;
    
    [self reset:NO];
}

- (void)viewDidUnload
{
    labels = nil;
    sliders = nil;
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

- (void)refleshLabels {
    for (UILabel *label in labels) {
        UISlider *slider = [sliders objectAtIndex:[labels indexOfObject:label]];
        label.text = [NSString stringWithFormat:@"%.2f", slider.value];
    }
}

- (void)reset:(BOOL)animated {
    
    void (^animations)() = ^{
        CGAffineTransform transfrom = CGAffineTransformIdentity;
        [(UISlider *)[sliders objectAtIndex:0] setValue:transfrom.a];
        [(UISlider *)[sliders objectAtIndex:1] setValue:transfrom.b];
        [(UISlider *)[sliders objectAtIndex:2] setValue:transfrom.c];
        [(UISlider *)[sliders objectAtIndex:3] setValue:transfrom.d];
        [(UISlider *)[sliders objectAtIndex:4] setValue:transfrom.tx];
        [(UISlider *)[sliders objectAtIndex:5] setValue:transfrom.ty];
        [self refleshLabels];
        expView.transform = transfrom;
    };

    if (animated) {
        [UIView animateWithDuration:0.3f animations:animations];
    } else {
        animations();
    }
}

- (IBAction)valueChangeAction:(UISlider *)sender {
    
    CGAffineTransform transform = expView.transform;
    NSLog(@"%@", NSStringFromCGAffineTransform(transform));
    
    NSUInteger index = [sliders indexOfObject:sender];
    switch (index) {
        case 0:
            transform.a = sender.value;
            break;
        case 1:
            transform.b = sender.value;
            break;
        case 2:
            transform.c = sender.value;
            break;
        case 3:
            transform.d = sender.value;
            break;
        case 4:
            transform.tx = sender.value;
            break;
        case 5:
            transform.ty = sender.value;
            break;
        default:
            break;
    }
    
    [self refleshLabels];
    expView.transform = transform;

}

- (IBAction)resetAction:(id)sender {
    [self reset:YES];
}


@end
