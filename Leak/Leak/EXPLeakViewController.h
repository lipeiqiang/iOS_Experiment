//
//  EXPLeakViewController.h
//  Leak
//
//  Created by 5deg_MacBookAir on 13/02/04.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPLeakViewController : UIViewController

- (IBAction)mallocAction:(id)sender;
- (IBAction)retainAction:(id)sender;
- (IBAction)autoreleaseAction:(id)sender;

- (IBAction)threadMallocAction:(id)sender;
- (IBAction)threadRetainAction:(id)sender;
- (IBAction)threadAutoreleaseAction:(id)sender;

@end
