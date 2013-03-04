//
//  EXPPickerViewController.h
//  Picker
//
//  Created by iwashita jiro on 13/01/22.
//  Copyright (c) 2013年 jiroiwas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPPickerViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pickedImageView;


- (IBAction)openCameraAction:(id)sender;
- (IBAction)openCamerarollAction:(id)sender;
- (IBAction)saveImageAction:(id)sender;

@end
