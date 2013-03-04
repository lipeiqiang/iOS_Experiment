//
//  EXPTableViewController.m
//  TableView
//
//  Created by 5deg_MacBookAir on 13/01/09.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import "EXPTableViewController.h"
#import "EXPTableAViewController.h"

@interface EXPTableViewController ()

@end

@implementation EXPTableViewController

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

- (IBAction)openTableAAction:(id)sender {
    UIViewController *controller = [[EXPTableAViewController alloc] initWithNibName:@"EXPTableAViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)openTableBAction:(id)sender {
}
- (IBAction)openTableCAction:(id)sender {
}
@end
