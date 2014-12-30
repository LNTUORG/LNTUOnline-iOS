//
//  JoinViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/30.
//  Copyright (c) 2014年 JieLee. All rights reserved.
//

#import "JoinViewController.h"
#import "MBProgressHUD+LJ.h"
#import "Common.h"

@interface JoinViewController () <UIWebViewDelegate>

@end

@implementation JoinViewController

- (void)viewDidLoad
{
    NSURL *url = [NSURL URLWithString:wantedURL ];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:req];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
}

#pragma mark 浏览器代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:waitStr];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}


- (IBAction)disappear:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIApplication sharedApplication].statusBarHidden = NO;
    
}

@end
