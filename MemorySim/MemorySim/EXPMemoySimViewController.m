//
//  EXPMemoySimViewController.m
//  MemorySim
//
//  Created by iwashita jiro on 12/12/27.
//  Copyright (c) 2012年 jiroiwas. All rights reserved.
//
#import <mach/mach.h>
#import <mach/mach_host.h>

#import "EXPMemoySimViewController.h"
#import "Stats.h"

@interface EXPMemoySimViewController ()

@end

@implementation EXPMemoySimViewController {
    int *_addr;
    unsigned long _size;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGRect frame = CGRectMake(0, 0, 320, 120);
    Stats *stats = [[Stats alloc] initWithFrame:frame];
    [self.view addSubview:stats];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations  {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (IBAction)alloc1KAction:(id)sender {
    [self allocWithSize:1024];
}

- (IBAction)alloc1MAction:(id)sender {
    [self allocWithSize:1024 * 1024];
}

- (IBAction)alloc10MAction:(id)sender {
    [self allocWithSize:(1024 * 1024) * 10];
}

- (IBAction)alloc100MAction:(id)sender {
    [self allocWithSize:(1024 * 1024) * 100];
}

- (IBAction)freeAction:(id)sender {
    _size = 0;
    [self free];
    [self refleshSizeLabel];
}

- (void)allocWithSize:(unsigned long)size {
    [self free];
    _size += size;
    _addr = (int *)malloc(_size);
    [self refleshSizeLabel];
}

- (void)free {
    free(_addr);
}

- (void)refleshSizeLabel {
    
    _sizeLabel.text = [NSString stringWithFormat:@"%lu", _size / 1024 / 1024];
    
    NSUInteger freeSize = [self get_free_memory];
    _freeSizeLabel.text = [NSString stringWithFormat:@"%u", freeSize / 1024 / 1024];
    
}


- (natural_t)get_free_memory {
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    vm_statistics_data_t vm_stat;
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        NSLog(@"Failed to fetch vm statistics");
        return 0;
    }
    
    natural_t mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}



@end

