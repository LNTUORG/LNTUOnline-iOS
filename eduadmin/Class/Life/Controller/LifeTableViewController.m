//
//  LifeTableViewController.m
//  eduadmin
//
//  Created by Li Jie on 15/5/26.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "LifeTableViewController.h"
#import "LJTools.h"
#import "Common.h"
#import "MJRefresh.h"
#import "HeaterTempCell.h"

@implementation LifeTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)refreshData {

    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@heater-temp/read", TOKENURL] params:nil success:^(id responseJSON) {
        
        self.arr = responseJSON;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HeaterTempCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TempCell"];
    
    if (!cell) {
        
        cell = [HeaterTempCell newHeaterTempCell];
    }
    
    NSArray *newArr = self.arr[indexPath.row];
    cell.info = newArr;
    
    return cell;
}

@end
