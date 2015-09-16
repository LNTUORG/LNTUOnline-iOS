//
//  MainNavigationViewController.m
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "MainNavigationViewController.h"
#import "PushViewController.h"

@interface MainNavigationViewController ()

@end

@implementation MainNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *launchImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    NSString *imageName = [NSString stringWithFormat:@"startimg0%d", arc4random() % 6];
    
    launchImageView.image = [UIImage imageNamed:imageName];
    
    
    [self.view addSubview:launchImageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.9f animations:^{
            
            launchImageView.alpha = 0.0;
        } completion:^(BOOL finished) {
            
            [launchImageView removeFromSuperview];
        }];
    });

    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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
