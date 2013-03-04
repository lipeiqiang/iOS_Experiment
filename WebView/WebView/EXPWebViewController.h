//
//  EXPWebViewController.h
//  WebView
//
//  Created by user1 on 12/09/28.
//  Copyright (c) 2012年 jiroiwas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPWebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)backAction:(id)sender;
- (IBAction)prevAction:(id)sender;
- (IBAction)homeAction:(id)sender;
- (IBAction)googleAction:(id)sender;
- (IBAction)reloadAction:(id)sender;

@end
