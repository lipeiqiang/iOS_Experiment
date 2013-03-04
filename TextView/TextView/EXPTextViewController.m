//
//  EXPTextViewController.m
//  TextView
//
//  Created by user1 on 12/09/25.
//  Copyright (c) 2012年 jiroiwas. All rights reserved.
//

#import "EXPTextViewController.h"

@interface EXPTextViewController ()

@end

@implementation EXPTextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect scrollFrame = _scrollView.frame;
    CGSize contentsSize = scrollFrame.size;
    scrollFrame.size.height = 60;
    _scrollView.frame = scrollFrame;
    _scrollView.contentSize = contentsSize;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if ([textField isEqual:_textField1]) {
        [_textField2 becomeFirstResponder];
    } else if ([textField isEqual:_textField2]) {
        [_textView1 becomeFirstResponder];
    }
    
    return NO;
}

@end
