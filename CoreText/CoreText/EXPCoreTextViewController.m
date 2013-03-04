//
//  EXPCoreTextViewController.m
//  CoreText
//
//  Created by iwashita jiro on 13/01/31.
//  Copyright (c) 2013年 jiroiwas. All rights reserved.
//

#import <CoreText/CoreText.h>

#import "EXPCoreTextViewController.h"

@interface EXPCoreTextViewController ()

@end

@implementation EXPCoreTextViewController {
    NSString *_text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self readText];
}

- (void)readText
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample.txt" ofType:nil];
    _text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    _attrView.text = _text;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keywordDidChange:(NSString *)keyword
{
    _attrView.keyword = keyword;
    [_attrView setNeedsDisplay];
}

#pragma mark textField delegate

- (BOOL)textField:(UITextField *)textField  shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *editedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self keywordDidChange:editedText];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self keywordDidChange:@""];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)viewTapped:(id)sender
{
    [_keywordField resignFirstResponder];
}



@end
