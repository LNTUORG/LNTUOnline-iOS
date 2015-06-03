//
//  UnpassScoreTableViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "UnpassScoreTableViewController.h"
#import "MBProgressHUD+LJ.h"
#import "LJTools.h"
#import "Common.h"
#import "UnpassGrade.h"
#import "MJExtension.h"
#import "PartGradeCell.h"
#import "MJRefresh.h"
#import "DetailTableViewController.h"

@interface UnpassScoreTableViewController ()

@end

@implementation UnpassScoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData) dateKey:@"unpass"];
    
    [self.tableView headerBeginRefreshing];
    
}

- (void)refreshData {
    
    [self getUnpassCoursesInfo];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _gradeArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PartGradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"part"];
    
    if (cell == nil) {
        cell = [PartGradeCell newPartGradeCell];
    }
    
    cell.unPassGrade = _gradeArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnpassGrade *grade = self.gradeArr[indexPath.row];
    
    [self performSegueWithIdentifier:@"unpass2detail" sender:grade.records];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailTableViewController *con = segue.destinationViewController;
    con.records = sender;
}


- (void)getUnpassCoursesInfo
{
    
    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@unpass-course/~self", MAINURL] params:nil success:^(id responseJSON) {
        
        self.gradeArr = [UnpassGrade objectArrayWithKeyValuesArray:responseJSON];
        
        if (self.gradeArr.count == 0) {
            
            [MBProgressHUD showError:@"居然无挂科，你超神了！"];
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tableView headerEndRefreshing];
    }];
}

@end
