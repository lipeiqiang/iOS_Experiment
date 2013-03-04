//
//  EXPWebViewController.m
//  WebView
//
//  Created by user1 on 12/09/28.
//  Copyright (c) 2012年 jiroiwas. All rights reserved.
//

#import "EXPWebViewController.h"

//#define kDefaultHome @"http://192.168.10.93"
//#define kDefaultHome @"http://dl.dropbox.com/u/23740315/html/index.html"
#define kDefaultHome @"hoge:hoge"

@interface EXPWebViewController ()

@end

@implementation EXPWebViewController

- (void)viewDidLoadL
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadWithURLString:kDefaultHome];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                        message:[error localizedDescription]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)loadWithURLString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (IBAction)backAction:(id)sender {
    [_webView goBack];
}

- (IBAction)prevAction:(id)sender {
    [_webView goForward];
}

- (IBAction)homeAction:(id)sender {
    [self loadWithURLString:kDefaultHome];
}

- (IBAction)googleAction:(id)sender {
    [self loadWithURLString:@"http://google.com"];
}

- (IBAction)reloadAction:(id)sender {
    [_webView reload];
}
@end
