//
//  EXPTransformViewController.h
//  Transform
//
//  Created by user1 on 12/09/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPTransformViewController : UIViewController {
    __unsafe_unretained IBOutlet UISlider *durationSlider;
}

- (IBAction)reset:(id)sender;
- (IBAction)exp1:(id)sender;
- (IBAction)exp2:(id)sender;
- (IBAction)exp3:(id)sender;

@end
