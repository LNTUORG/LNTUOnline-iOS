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

@interface ExamPlanTableViewController ()
{
    NSArray *_planArr;
}
@end

@implementation ExamPlanTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [LJFileTool getFilePath:[self getAddress:examPlanFileName]];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSArray *dict = [NSArray arrayWithContentsOfFile:filePath];
        
        [self analyticalData:dict];
    }else{
        [self refreshData];
    }
}


#pragma mark 解析数据
- (void)analyticalData:(id)json
{
    _planArr = [ExamPlan objectArrayWithKeyValuesArray:json];
    
    NSArray *arr = [_planArr sortedArrayUsingComparator:^NSComparisonResult(ExamPlan *obj1, ExamPlan *obj2) {
        
        NSComparisonResult result = [obj1.time compare:obj2.time];
        return result;
    }];
    
    _planArr = arr;
    [self.tableView reloadData];
}


- (void)refreshData
{
    [MBProgressHUD showMessage:waitStr];
    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@examPlan/info",sinaURL] params:nil success:^(id responseJSON) {

        [LJFileTool writeToFileContent:responseJSON withFileName:[self getAddress:examPlanFileName]];
        [self analyticalData:responseJSON];
        [MBProgressHUD hideHUD];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:nullStr];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSString *)getAddress:(NSString *)fileName {
    
    NSString *filePath = [LJFileTool getFilePath:loginFileName];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        return [NSString stringWithFormat:@"%@%@",dict[@"userName"],fileName];
    }else {
        return @"error";
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _planArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExamPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"epl"];
    
    if (cell == nil) {
        cell = [ExamPlanCell newExanPlanCell];
    }
    
    cell.plan = _planArr[indexPath.row];
    
    return cell;
}

- (IBAction)refresh:(id)sender {
    [self refreshData];
}
@end
