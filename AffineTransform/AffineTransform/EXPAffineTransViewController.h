//
//  EXPAffineTransViewController.h
//  AffineTransform
//
//  Created by user1 on 12/09/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPAffineTransViewController : UIViewController {
    
    IBOutletCollection(UILabel) NSArray *labels;
    IBOutletCollection(UISlider) NSArray *sliders;
}
- (IBAction)valueChangeAction:(UISlider *)sender;

- (IBAction)resetAction:(id)sender;

@end
