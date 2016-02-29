//
//  SkillTestTableViewController.m
//  eduadmin
//
//  Created by Li Jie on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "SkillTestTableViewController.h"
#import "MBProgressHUD+LJ.h"
#import "LJTools.h"
#import "Common.h"
#import "MJExtension.h"
#import "SkillTest.h"
#import "SkillTestCell.h"
#import "MJRefresh.h"

@interface SkillTestTableViewController ()

@end

@implementation SkillTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)refreshData {
    
    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@skill-test-score/~self", MAINURL] params:nil success:^(id responseJSON) {
        
        self.skillArr = [SkillTest mj_objectArrayWithKeyValuesArray:responseJSON];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD showError:NULLSTR];
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.skillArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SkillTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkillCell" forIndexPath:indexPath];
    
    cell.sTest = self.skillArr[indexPath.row];
    
    return cell;
}

@end
