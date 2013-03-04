//
//  EXPThreadViewController.m
//  Thread
//
//  Created by 5deg_MacBookAir on 13/02/07.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "EXPThreadViewController.h"
#import "EXPSimpleObject.h"

#define EXP_THREAD_TIMER_COLOR [UIColor greenColor]
#define EXP_THREAD_NSTHREAD_COLOR [UIColor redColor]
#define EXP_THREAD_OPEQUEUE_COLOR [UIColor blueColor]
#define EXP_THREAD_GCD_COLOR [UIColor orangeColor]

const char* EXP_THREAD_QUEUE_LABEL_SERIAL = "com.hoge.thread.gcd.serial";
const char* EXP_THREAD_QUEUE_LABEL_CONCURRENT = "com.hoge.thread.gcd.concurrent";
const CGFloat EXP_THREAD_PROC_INTERVAL = 0.5f;
const NSInteger EXP_THREAD_PROC_LIFETIME = 20;

@interface EXPThreadViewController() <EXPSimpleDelegate>
- (void)addSimpleLayer:(CALayer *)layer;
- (void)didEndSimpleLife:(EXPSimple *)object;
@end

@implementation EXPThreadViewController {

    dispatch_queue_t _gcdSerialQueue;
    dispatch_queue_t _gcdConcurrentQueue;
    
    NSOperationQueue *_opeQueue;
    
}

- (dispatch_queue_t)gcdSerialQueue
{
    if (_gcdSerialQueue == NULL) {
        _gcdSerialQueue = dispatch_queue_create(EXP_THREAD_QUEUE_LABEL_SERIAL, DISPATCH_QUEUE_SERIAL);
    }
    return _gcdSerialQueue;
}

- (dispatch_queue_t)gcdConcurrentQueue
{
    if (_gcdConcurrentQueue == NULL) {
        _gcdConcurrentQueue = dispatch_queue_create(EXP_THREAD_QUEUE_LABEL_CONCURRENT, DISPATCH_QUEUE_CONCURRENT);
    }
    return _gcdConcurrentQueue;
}

- (NSOperationQueue *)opeQueue
{
    if (!_opeQueue) {
        _opeQueue = [[NSOperationQueue alloc] init];
    }
    return _opeQueue;
}


#pragma override
- (void)viewDidLoad
{
    [super viewDidLoad];
    srand(time(nil));
    
    CGSize contentSize = _screenView.bounds.size;
    contentSize.height *= 2;
    contentSize.width *= 2;
    _screenView.contentSize = contentSize;
    
    CGPoint contentOffset = CGPointZero;
    contentOffset.x = contentSize.width / 4;
    contentOffset.y = contentSize.height / 4;
    _screenView.contentOffset = contentOffset;
    
    [_scrollView addSubview:_toolBar];
    _scrollView.contentSize = _toolBar.bounds.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma EXPSimpleDelegate
- (void)addSimpleLayer:(CALayer *)layer
{
    CGSize baseSize = _screenView.bounds.size;
    CGPoint offset = _screenView.contentOffset;
    int x = rand() % (int)baseSize.width;
    int y = rand() % (int)baseSize.height;
    layer.position = CGPointMake(offset.x + x, offset.y + y);
    [_screenView.layer addSublayer:layer];
}

- (void)didEndSimpleLife:(EXPSimple *)object
{
//    [_simpleObjects removeObject:object];
}

#pragma proc

// 通常の処理
- (void)procObject:(NSInteger)lifeTime interval:(NSTimeInterval)interval color:(UIColor *)color
{
    EXPSimple *object = [[EXPSimple alloc] init];
    object.delegate = self;
    object.lifeTimeCount = lifeTime;
    object.color = color;
    [object main];
}

// セレクタ指定用の処理
- (void)procObjectWithArgs:(NSDictionary *)args
{
    NSInteger lifeTime = [args[@"lifeTime"] intValue];
    NSTimeInterval interval = [args[@"interval"] doubleValue];
    UIColor *color = args[@"color"];
    [self procObject:lifeTime interval:interval color:color];
}

// NSTimer（標準）による処理
- (void)procObjectWithTimer:(NSTimer *)timer
{
    NSMutableDictionary *userInfo = timer.userInfo;
    EXPSimple *object = userInfo[@"object"];
    if (!object) {
        object = [[EXPSimple alloc] init];
        object.delegate = self;
        object.lifeTimeCount = EXP_THREAD_PROC_LIFETIME;
        object.color = EXP_THREAD_TIMER_COLOR;
        userInfo[@"object"] = object;
    }
    
    NSInteger lifeTime = [object proc];
    if (lifeTime == 0) {
        [timer invalidate];
    }
}

// GCDによる処理
- (void)procWithGCDQueue:(dispatch_queue_t) queue
{
    dispatch_async(queue, ^{
        [self procObject:EXP_THREAD_PROC_LIFETIME
                interval:EXP_THREAD_PROC_INTERVAL
                   color:EXP_THREAD_GCD_COLOR];
    });
}


#pragma IBAction

// NSThreadによる通常のアクション
- (IBAction)nsThreadAction:(id)sender {
    NSDictionary *args = @{ @"lifeTime": @(EXP_THREAD_PROC_LIFETIME),
                            @"interval": @(EXP_THREAD_PROC_INTERVAL),
                            @"color": EXP_THREAD_NSTHREAD_COLOR
    };
    NSThread *thread = [[NSThread alloc] initWithTarget:self
                                               selector:@selector(procObjectWithArgs:)
                                                 object:args];
    [thread start];
}

- (IBAction)nsOpeSerialAction:(id)sender
{
    
    NSOperationQueue *queue = [self opeQueue];
    EXPSimple *object = [[EXPSimple alloc] init];
    object.delegate = self;
    object.lifeTimeCount = EXP_THREAD_PROC_LIFETIME;
    object.color = EXP_THREAD_OPEQUEUE_COLOR;
    [queue addOperation:object];
    
}

- (IBAction)nsOpeConcurrentAction:(id)sender
{
    
}

#pragma CGD
// GCDのメインキューによるアクション
- (IBAction)gcdMainQueueAction:(id)sender
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    [self procWithGCDQueue:queue];
}

// GCDのグローバルキューによるアクション
- (IBAction)gcdGlobalQueueAction:(id)sender
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [self procWithGCDQueue:queue];
}

// GCDのシリアルキューによるアクション
- (IBAction)gcdSerialQueueAction:(id)sender
{
    dispatch_queue_t queue = [self gcdSerialQueue];
    [self procWithGCDQueue:queue];
}

// GCDのコンカレントキューによるアクション
- (IBAction)gcdConcurrentQeueAction:(id)sender
{
    dispatch_queue_t queue = [self gcdConcurrentQueue];
    [self procWithGCDQueue:queue];
}


#pragma NSTimer

// 通常のタイマーによるアクション
- (IBAction)nsTimerAction:(id)sender
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];       
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:EXP_THREAD_PROC_INTERVAL
                                                      target:self
                                                    selector:@selector(procObjectWithTimer:) userInfo:userInfo
                                                     repeats:YES];
    [timer fire];
}

// mainRunLoop上でのタイマーによるアクション
- (IBAction)nsTimerOnRunloopAction:(id)sender
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSTimer *timer = [NSTimer timerWithTimeInterval:EXP_THREAD_PROC_INTERVAL
                                             target:self
                                           selector:@selector(procObjectWithTimer:)
                                           userInfo:userInfo
                                            repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}



@end



