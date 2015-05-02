//
//  OneKeyTableViewController.m
//  eduadmin
//
//  Created by JieLee on 4/21/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import "OneKeyTableViewController.h"
#import "LJTools.h"
#import "Common.h"
#import "RatingInfo.h"
#import "MBProgressHUD+LJ.h"
#import "MJExtension.h"
#import "OneKeyRateCell.h"
#import "MJRefresh.h"

@interface OneKeyTableViewController () <UIAlertViewDelegate>

@end

@implementation OneKeyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData) dateKey:@"onekey"];
    
    [self.tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshData {

    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@course-eva-info/~self", MAINURL] params:nil success:^(id responseJSON) {
        
        self.courseArr = [RatingInfo objectArrayWithKeyValuesArray:responseJSON];
        
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tableView headerEndRefreshing];
        [MBProgressHUD showError:NULLSTR];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RatingInfo *info = self.courseArr[indexPath.row];
    
    if ([info.done isEqualToString:@"0"]) {
        
        NSDictionary *dict = @{@"evaKey": info.evaKey};
        
        [LJHTTPTool postJSONWithURL:[NSString stringWithFormat:@"%@course-eva-info/~self/do:eva", MAINURL] params:dict success:^(id responseJSON) {
            
            info.done = @"1";
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            [MBProgressHUD showSuccess:@"成功"];
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"似乎有点不对劲"];
        }];
    }
    
    if (indexPath.row == self.courseArr.count - 1) {
        
        [self refreshData];
        [self ratingApp];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.courseArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OneKeyRateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RateCell"];
    
    if (!cell) {
        
        cell = [OneKeyRateCell newOneKeyCell];
    }
    
    cell.info = self.courseArr[indexPath.row];
    
    return cell;
}

- (void)ratingApp {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"给个好评吧" message:@"给过老师好评，是不是心情棒棒哒，也给我们个好评吧" delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"好哒", nil];
    [alert show];
}

#pragma mark alert代理
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *url = STOREURL;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}
@end