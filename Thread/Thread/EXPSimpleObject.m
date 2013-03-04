//
//  EXPSimpleObject.m
//  Thread
//
//  Created by 5deg_MacBookAir on 13/02/14.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "EXPSimpleObject.h"
#import "EXPThreadViewController.h"

const NSInteger EXP_THREAD_MOVE_THRESHOLD = 10;


@implementation EXPSimple {
    NSInteger _initLifeTime;
}

- (void)main
{
    while ([self proc] > 0 && self.isCancelled == NO) {
        [NSThread sleepForTimeInterval:EXP_THREAD_PROC_INTERVAL];
    }
}

- (void)start
{
    while ([self proc] > 0 && self.isCancelled == NO) {
        [NSThread sleepForTimeInterval:EXP_THREAD_PROC_INTERVAL];
    }
}

- (void)setIsConcurrent:(BOOL)hoge
{
    _isConc;
}

- (BOOL)isConcurrent
{
    _isConc;
//    return _isConcurrent;
}

- (NSInteger)proc
{
    
    if (!_layer) {
        _layer = [[CALayer alloc] init];
        _layer.frame = CGRectMake(0, 0, 20, 20);
        _layer.backgroundColor = _color.CGColor;
        _initLifeTime = _lifeTimeCount;
        
        if ([[NSThread currentThread] isMainThread]) {
            _layer.borderWidth = 1;
            _layer.borderColor = [UIColor darkGrayColor].CGColor;
            [self addSimpleLayer];
        }
        [self performSelectorOnMainThread:@selector(addSimpleLayer) withObject:nil waitUntilDone:NO];
        
    }
    
    if (_lifeTimeCount > 0) {
        _lifeTimeCount--;
        if ([[NSThread currentThread] isMainThread]) {
            [self moveSimpleLayer];
        }
        [self performSelectorOnMainThread:@selector(moveSimpleLayer) withObject:nil waitUntilDone:NO];
    }
    
    if (_lifeTimeCount <= 0) {
        if ([[NSThread currentThread] isMainThread]) {
            [self removeSimpleLayer];
        }
        [self performSelectorOnMainThread:@selector(removeSimpleLayer) withObject:nil waitUntilDone:YES];
    }
    
    //    NSLog(@"lifeTimeCount:%d", _lifeTimeCount);
    return _lifeTimeCount;
}

- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait
{
    [super performSelectorOnMainThread:aSelector withObject:arg waitUntilDone:wait];
    [[NSRunLoop mainRunLoop] runUntilDate:nil];
}

- (void)addSimpleLayer
{
    [_delegate addSimpleLayer:_layer];
}

- (void)moveSimpleLayer
{
    _layer.opacity = (CGFloat)_lifeTimeCount / (CGFloat)_initLifeTime;
    
    CGPoint pos = _layer.position;
    pos.x += (rand() % (EXP_THREAD_MOVE_THRESHOLD * 2 + 1)) - EXP_THREAD_MOVE_THRESHOLD;
    pos.y += (rand() % (EXP_THREAD_MOVE_THRESHOLD * 2 + 1)) - EXP_THREAD_MOVE_THRESHOLD;
    _layer.position = pos;
}

- (void)removeSimpleLayer
{
    [_layer removeFromSuperlayer];
    [_delegate didEndSimpleLife:self];
}

- (void)dealloc {
    NSLog(@"dealloc:%@", NSStringFromClass(self.class));
}
@end
