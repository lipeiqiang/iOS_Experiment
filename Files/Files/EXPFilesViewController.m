//
//  EXPFilesViewController.m
//  Files
//
//  Created by 5deg_MacBookAir on 13/03/12.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import "EXPFilesViewController.h"
#import "EXPDirectoryViewController.h"

@interface EXPFilesViewController ()

@end

@implementation EXPFilesViewController
{
    UINavigationController *_dirNavigationController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Input Accessory View
    _textView.inputAccessoryView = _accessoryToolBar;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark IBAction
- (IBAction)closeKeyboard:(id)sender
{
    [_textView resignFirstResponder];
}

- (IBAction)openDirectory:(id)sender {
    EXPDirectoryViewController *direcotryViewController = [[EXPDirectoryViewController alloc] init];
    _dirNavigationController = [[UINavigationController alloc] initWithRootViewController:direcotryViewController];
    [self presentViewController:_dirNavigationController
                       animated:YES
                     completion:nil];
}

#pragma mark -
#pragma UITextView Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
}

@end
