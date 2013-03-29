//
//  EXPContainerChildViewController.h
//  Container
//
//  Created by ブックライブ on 2013/03/29.
//  Copyright (c) 2013年 BookLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EXPContainerPageController <NSObject>
- (void)moveToNextChildView;
- (void)moveToPrevChildView;
@end

@interface EXPContainerChildViewController : UIViewController
- (IBAction)nextButtonDidTapped:(id)sender;
- (IBAction)prevButtonDidTapped:(id)sender;
@end
