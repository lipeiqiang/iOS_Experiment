//
//  EXPModalOpenViewController.m
//  Modal
//
//  Created by user1 on 12/10/25.
//  Copyright (c) 2012年 jiroiwas. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "EXPModalOpenViewController.h"
#import "EXPModalViewController.h"

@interface EXPModalOpenViewController ()
{
    EXPModalOpenViewController *openViewController;
}

@end

@implementation EXPModalOpenViewController

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (IBAction)openModalViewAction:(id)sender
{
    
    EXPModalViewController *controller = [[EXPModalViewController alloc] initWithNibName:@"EXPModalViewController" bundle:nil];
//    controller.modalPresentationStyle = UIModalPresentationFormSheet;

#if 1
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentModalViewController:navigationController animated:YES];
#else
    [self presentModalViewController:controller animated:YES];
#endif
    
}

- (IBAction)addSubViewAction:(id)sender {
    if (!openViewController) {
        openViewController = [[EXPModalOpenViewController alloc] initWithNibName:@"EXPModalOpenViewController_iPad" bundle:nil];
        openViewController.view.layer.borderWidth = 1;
    }

    CGRect frame = self.view.bounds;
    frame.origin.x = 100;
    frame.origin.y = 100;
    frame.size.width -=200;
    frame.size.height -=200;

#if 1
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:openViewController];
    navigationController.view.frame = frame;
    [self.view addSubview:navigationController.view];
#else
    openViewController.view.frame = frame;
    [self.view addSubview:openViewController.view];
#endif

}

@end
