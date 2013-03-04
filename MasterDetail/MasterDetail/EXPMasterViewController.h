//
//  EXPMasterViewController.h
//  MasterDetail
//
//  Created by 5deg_MacBookAir on 13/01/10.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EXPDetailViewController;

#import <CoreData/CoreData.h>

@interface EXPMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) EXPDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
