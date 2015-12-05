//
//  PushViewController.m
//  eduadmin
//
//  Created by Li Jie on 15/2/15.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController
@synthesize recievedContent;
@synthesize url;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (url) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        self.textView.text = recievedContent;
    } else {
        
        self.textView.text = recievedContent;
    }
}

@end
