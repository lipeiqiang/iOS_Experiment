//
//  EXPFilesViewController.h
//  Files
//
//  Created by 5deg_MacBookAir on 13/03/12.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPFilesViewController : UIViewController<UITextViewDelegate, UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIToolbar *accessoryToolBar;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)openDirectory:(id)sender;

@end
