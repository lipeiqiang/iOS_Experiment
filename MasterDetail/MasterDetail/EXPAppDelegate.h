//
//  EXPAppDelegate.h
//  MasterDetail
//
//  Created by 5deg_MacBookAir on 13/01/10.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
