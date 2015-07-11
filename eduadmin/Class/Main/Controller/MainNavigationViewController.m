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
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PushViewController *con = segue.destinationViewController;
    
    NSArray *array = sender;
    
    if (array.count > 1) {
        con.recievedContent = array[0];
        con.url = array[1];
    } else {
        
        con.recievedContent = array[0];
    }
    
}

@end
