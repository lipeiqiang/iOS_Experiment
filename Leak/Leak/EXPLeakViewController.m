//
//  EXPLeakViewController.m
//  Leak
//
//  Created by 5deg_MacBookAir on 13/02/04.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import "EXPLeakViewController.h"
#import "EXPNoArc.h"

@interface EXPLeakViewController ()

@end

@implementation EXPLeakViewController

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

- (IBAction)mallocAction:(id)sender {
    
    EXPNoArc *noArc = [[EXPNoArc alloc] init];
    void *p = [noArc mallocTest];
}

- (IBAction)retainAction:(id)sender {
    EXPNoArc *noArc = [[EXPNoArc alloc] init];
    id obj = [noArc retainObject];
    
}

- (IBAction)autoreleaseAction:(id)sender {
    EXPNoArc *noArc = [[EXPNoArc alloc] init];
    id obj = [noArc autoreleaseObject];
}

- (IBAction)threadMallocAction:(id)sender
{
    EXPNoArc *noArc = [[EXPNoArc alloc] init];
    NSThread *thread = [[NSThread alloc] initWithTarget:noArc selector:@selector(mallocTest) object:nil];
    [thread start];
}

- (IBAction)threadRetainAction:(id)sender
{
    EXPNoArc *noArc = [[EXPNoArc alloc] init];
    NSThread *thread = [[NSThread alloc] initWithTarget:noArc selector:@selector(retainObject) object:nil];
    [thread start];
}

- (IBAction)threadAutoreleaseAction:(id)sender
{
    EXPNoArc *noArc = [[EXPNoArc alloc] init];
    NSThread *thread = [[NSThread alloc] initWithTarget:noArc selector:@selector(autoreleaseObject) object:nil];
    [thread start];
}



@end
