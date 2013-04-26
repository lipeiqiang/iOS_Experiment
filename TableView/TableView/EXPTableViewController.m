//
//  EXPTableViewController.m
//  TableView
//
//  Created by 5deg_MacBookAir on 13/01/09.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import "EXPTableViewController.h"
#import "EXPTableAViewController.h"
#import "EXPTableBViewController.h"

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
    UITableViewController *controller = [[EXPTableAViewController alloc] initWithNibName:@"EXPTableAViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 70)];
    headerView.backgroundColor = [UIColor blueColor];
    controller.tableView.tableHeaderView = headerView;

}
- (IBAction)openTableBAction:(id)sender {
    UIViewController *controller = [[EXPTableBViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];    
}
- (IBAction)openTableCAction:(id)sender {
}
@end
