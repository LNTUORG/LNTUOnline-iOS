//
//  SkillTestTableViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/31.
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
{
    NSArray *_skillArr;
}
@end

@implementation SkillTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData) dateKey:@"table"];
    
    [self.tableView headerBeginRefreshing];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
}

- (void)refreshData {
    
    
//    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@grades/skillTestScoresInfo",sinaURL] params:nil success:^(id responseJSON) {
//        
//        _skillArr = [SkillTest objectArrayWithKeyValuesArray:responseJSON];
//        [self.tableView reloadData];
//        [self.tableView headerEndRefreshing];
//        
//    } failure:^(NSError *error) {
//        
//        [MBProgressHUD showError:nullStr];
//        [self.tableView headerEndRefreshing];
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _skillArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SkillTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"skill"];
    
    if (cell == nil) {
        cell = [SkillTestCell newSkillTestCell];
    }
    
    cell.sTest = _skillArr[indexPath.row];
    
    return cell;
}

@end
