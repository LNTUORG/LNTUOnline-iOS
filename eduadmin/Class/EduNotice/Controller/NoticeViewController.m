//
//  NoticeViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "NoticeViewController.h"
#import "Common.h"
#import "MBProgressHUD+LJ.h"

@interface NoticeViewController () <UIWebViewDelegate>

@end

@implementation NoticeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:noticeURL];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:req];
    
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

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    
}

- (IBAction)goToSafari:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:noticeURL]];
}

@end
