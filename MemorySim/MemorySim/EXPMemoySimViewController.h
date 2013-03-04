//
//  EXPMemoySimViewController.h
//  MemorySim
//
//  Created by iwashita jiro on 12/12/27.
//  Copyright (c) 2012年 jiroiwas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPMemoySimViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *sizeLabel;
@property (retain, nonatomic) IBOutlet UILabel *freeSizeLabel;

- (IBAction)alloc1KAction:(id)sender;
- (IBAction)alloc1MAction:(id)sender;
- (IBAction)alloc10MAction:(id)sender;
- (IBAction)alloc100MAction:(id)sender;
- (IBAction)freeAction:(id)sender;

@end
