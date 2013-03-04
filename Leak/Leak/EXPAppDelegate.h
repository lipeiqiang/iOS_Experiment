//
//  EXPAppDelegate.h
//  Leak
//
//  Created by 5deg_MacBookAir on 13/02/04.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EXPLeakViewController;

@interface EXPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EXPLeakViewController *viewController;

@end
