//
//  EXPThreadViewController.h
//  Thread
//
//  Created by 5deg_MacBookAir on 13/02/07.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const char* EXP_THREAD_QUEUE_LABEL_SERIAL;
extern const char* EXP_THREAD_QUEUE_LABEL_CONCURRENT;
extern const CGFloat EXP_THREAD_PROC_INTERVAL;
extern const NSInteger EXP_THREAD_PROC_LIFETIME;

@interface EXPThreadViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *screenView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

- (IBAction)nsThreadAction:(id)sender;

- (IBAction)nsOpeSerialAction:(id)sender;
- (IBAction)nsOpeConcurrentAction:(id)sender;

- (IBAction)gcdMainQueueAction:(id)sender;
- (IBAction)gcdGlobalQueueAction:(id)sender;
- (IBAction)gcdSerialQueueAction:(id)sender;
- (IBAction)gcdConcurrentQeueAction:(id)sender;

- (IBAction)nsTimerAction:(id)sender;
- (IBAction)nsTimerOnRunloopAction:(id)sender;

@end
