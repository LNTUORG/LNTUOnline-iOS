//
//  JWExamPlanTableViewController.m
//  lntuApp
//
//  Created by 李杰 on 14/10/2.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "ExamPlanTableViewController.h"
#import "MBProgressHUD+LJ.h"
#import "LJTools.h"
#import "Common.h"
#import "MJExtension.h"
#import "ExamPlanCell.h"
#import "ExamPlan.h"
#import "MJRefresh.h"

@interface ExamPlanTableViewController ()


@end

@implementation ExamPlanTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData) dateKey:@"table"];
    
    NSString *filePath = [LJFileTool getFilePath:examPlanFileName];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSArray *dict = [NSArray arrayWithContentsOfFile:filePath];
        
        [self analyticalData:dict];
    }else{
        [self.tableView headerBeginRefreshing];
    }
    
}


#pragma mark 解析数据
- (void)analyticalData:(id)json
{
    self.planArr = [ExamPlan objectArrayWithKeyValuesArray:json];
    
    NSArray *arr = [self.planArr sortedArrayUsingComparator:^NSComparisonResult(ExamPlan *obj1, ExamPlan *obj2) {
        
        NSComparisonResult result = [obj1.startTime compare:obj2.startTime];
        return result;
    }];
    
    self.planArr = arr;
    [self.tableView reloadData];
}


- (void)refreshData
{
    
    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@exam-plan/~self", MAINURL] params:nil success:^(id responseJSON) {
        
        [LJFileTool writeToFileContent:responseJSON withFileName:examPlanFileName];
        [self analyticalData:responseJSON];
        [self.tableView headerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD showError:NULLSTR];
        [self.tableView headerEndRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.planArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExamPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"epl"];
    
    if (cell == nil) {
        cell = [ExamPlanCell newExanPlanCell];
    }
    
    cell.plan = self.planArr[indexPath.row];
    
    return cell;
}

@end
