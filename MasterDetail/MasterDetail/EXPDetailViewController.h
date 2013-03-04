//
//  EXPDetailViewController.h
//  MasterDetail
//
//  Created by 5deg_MacBookAir on 13/01/10.
//  Copyright (c) 2013年 5deg_MacBookAir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
