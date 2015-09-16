//
//  JoinViewController.m
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "ShowWebViewController.h"
#import "MBProgressHUD+LJ.h"
#import "Common.h"

@interface ShowWebViewController () <UIWebViewDelegate>


@end

@implementation ShowWebViewController

@synthesize webURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:webURL ];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:req];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
}

#pragma mark 浏览器代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([self.webView canGoBack]) {
        self.goBackButton.enabled = YES;
    }else{self.goBackButton.enabled = NO;}
    
    if ([self.webView canGoForward]) {
        self.goNextButton.enabled = YES;
    }else{self.goNextButton.enabled = NO;}
    
    [MBProgressHUD showMessage:WAITSTR];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}


- (IBAction)goBack:(id)sender {
    
    [self.webView goBack];
}

- (IBAction)goNext:(id)sender {
    [self.webView goForward];
}

- (IBAction)disappear:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIApplication sharedApplication].statusBarHidden = NO;
    
}

@end
