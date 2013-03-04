//
//  EXPNoArc.m
//  Leak
//
//  Created by 5deg_MacBookAir on 13/02/04.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import "EXPNoArc.h"

@implementation EXPNoArc

- (void *)mallocTest
{
    void *hoge = malloc(1024 * 1024);
    
    return hoge;
}

- (id)retainObject
{
    id obj = [[NSObject alloc] init];
    
    for (int i=0; i<1024; i++) {
        [[NSObject alloc] init];
    }
    
    return obj;
}

- (id)autoreleaseObject
{
    id obj = [[[NSObject alloc] init] autorelease];
    return obj;
}

@end
