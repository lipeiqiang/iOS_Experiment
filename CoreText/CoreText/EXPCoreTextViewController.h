//
//  EXPCoreTextViewController.h
//  CoreText
//
//  Created by iwashita jiro on 13/01/31.
//  Copyright (c) 2013年 jiroiwas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPAttributedView.h"

@interface EXPCoreTextViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet EXPAttributedView *attrView;
@property (weak, nonatomic) IBOutlet UITextField *keywordField;

- (IBAction)viewTapped:(id)sender;

@end
