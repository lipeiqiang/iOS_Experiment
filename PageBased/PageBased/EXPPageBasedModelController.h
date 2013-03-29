//
//  EXPPageBasedModelController.h
//  PageBased
//
//  Created by ブックライブ on 2013/03/29.
//  Copyright (c) 2013年 BookLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EXPPageBasedDataViewController;

@interface EXPPageBasedModelController : NSObject <UIPageViewControllerDataSource>

- (EXPPageBasedDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(EXPPageBasedDataViewController *)viewController;

@end
