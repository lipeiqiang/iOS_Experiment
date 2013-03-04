//
//  EXPSimpleObject.h
//  Thread
//
//  Created by 5deg_MacBookAir on 13/02/14.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class EXPSimple;
@protocol EXPSimpleDelegate <NSObject>
- (void)addSimpleLayer:(CALayer *)layer;
- (void)didEndSimpleLife:(EXPSimple *)object;
@end

@interface EXPSimple : NSOperation
@property (nonatomic, weak) id<EXPSimpleDelegate> delegate;
@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSInteger lifeTimeCount;

@property (nonatomic) BOOL isConc;

- (NSInteger)proc;
@end
