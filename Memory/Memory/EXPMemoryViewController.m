//
//  EXPMemoryViewController.m
//  Memory
//
//  Created by ブックライブ on 2013/02/20.
//  Copyright (c) 2013年 BookLive. All rights reserved.
//

#import "EXPMemoryViewController.h"

#import <mach/host_info.h>
#import <mach/mach_init.h>
#import <mach/mach_host.h>

@interface EXPMemoryViewController ()

@end

@implementation EXPMemoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self refleshDebugInfo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// デバッグ用ラベル
- (void)refleshDebugInfo:(NSTimer *)timer {
    const NSTimeInterval refleshInterval = 0.25f;
    
    UIView *baseView = self.view;
    UILabel *debugInfoLabel = [timer userInfo];
    
    if (![debugInfoLabel superview]) {
        debugInfoLabel = [[UILabel alloc] init];
        debugInfoLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        debugInfoLabel.textColor = [UIColor whiteColor];
        [baseView addSubview:debugInfoLabel];
    }
    
    if (!timer) {
        NSTimer *debugTimer = [NSTimer scheduledTimerWithTimeInterval:refleshInterval
                                                               target:self
                                                             selector:@selector(refleshDebugInfo:)
                                                             userInfo:debugInfoLabel
                                                              repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:debugTimer forMode:NSRunLoopCommonModes];
    }
    
    // debug info
    NSInteger thumbCount = 0;
//    for (UIView *view in self.tableView.subviews) {
//        if ([view isKindOfClass:[BLBookShelfThumbnailImage class]]) {
//            thumbCount++;
//        }
//    }
    
    /* import hedder
     #import <mach/host_info.h>
     #import <mach/mach_init.h>
     #import <mach/mach_host.h>
     */
    float (^getFreeMem)(void) = ^{
        struct vm_statistics a_vm_info;
        mach_msg_type_number_t a_count = HOST_VM_INFO_COUNT;
        host_statistics( mach_host_self(), HOST_VM_INFO, (host_info_t)&a_vm_info ,&a_count);
        float size = ((a_vm_info.free_count * vm_page_size)/1024.0)/1024.0;
        return size;
    };
    float freeMem = getFreeMem();
    
    NSString *text = [NSString stringWithFormat:@"thumbs:%d free:%0.1fMB", thumbCount, freeMem];
    debugInfoLabel.text = text;
    
    CGRect labelFrame = CGRectMake(0, baseView.bounds.size.height - 60, baseView.bounds.size.width, 20);
    debugInfoLabel.frame = labelFrame;
    [baseView bringSubviewToFront:debugInfoLabel];
    
}


@end
