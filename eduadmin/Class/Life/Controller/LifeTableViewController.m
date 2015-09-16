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
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData) dateKey:@"heater_temp"];
    
    [self.tableView headerBeginRefreshing];
}

- (void)refreshData {

    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@heater-temp/read", TOKENURL] params:nil success:^(id responseJSON) {
        
        self.arr = responseJSON;
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tableView headerEndRefreshing];
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
