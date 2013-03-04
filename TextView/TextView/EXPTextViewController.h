//
//  EXPTextViewController.h
//  TextView
//
//  Created by user1 on 12/09/25.
//  Copyright (c) 2012年 jiroiwas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPTextViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

