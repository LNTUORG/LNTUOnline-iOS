//
//  MainNavigationViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "MainNavigationViewController.h"
#import "PushViewController.h"

@interface MainNavigationViewController ()

@end

@implementation MainNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSThread sleepForTimeInterval:0.6f];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PushViewController *con = segue.destinationViewController;
    con.recievedContent = sender;
}

@end
