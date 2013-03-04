//
//  EXPNoArc.h
//  Leak
//
//  Created by 5deg_MacBookAir on 13/02/04.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXPNoArc : NSObject

- (void *)mallocTest;

- (id)retainObject;
- (id)autoreleaseObject;


@end
