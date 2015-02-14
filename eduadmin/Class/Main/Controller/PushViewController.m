//
//  PushViewController.m
//  eduadmin
//
//  Created by JieLee on 15/2/15.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController
@synthesize recievedContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = recievedContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
