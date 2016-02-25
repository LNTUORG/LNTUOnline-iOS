//
//  JWGradeViewController.m
//  lntuApp
//
//  Created by Li Jie on 14/10/1.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "GradeViewController.h"
#import "Common.h"
#import "LJTools.h"
#import "MBProgressHUD+LJ.h"
#import "MyGrade.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "DetailGradeController.h"
#import "PartGradeCell.h"

@interface GradeViewController () <UIAlertViewDelegate, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation GradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gradeView.tableFooterView = [[UIView alloc] init];
    
    NSInteger year = [LJTimeTool getCurrentYear];
    
    if ([LJTimeTool getCurrentMonth] < 5) {
        
        year -= 1;
    }
    
    self.yearArr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", (int)year], [NSString stringWithFormat:@"%d", (int)year-1], [NSString stringWithFormat:@"%d", (int)year-2], [NSString stringWithFormat:@"%d", (int)year-3], [NSString stringWithFormat:@"%d", (int)year-4], [NSString stringWithFormat:@"%d", (int)year-5], nil];
    
    self.termArr = [NSArray arrayWithObjects:@"春", @"秋", nil];
    
    self.currentGradeArr = [NSMutableArray array];
    
    self.yearIndex = 0;
    
    if ([LJTimeTool getCurrentMonth]>=5 && [LJTimeTool getCurrentMonth]<11) {
        
        self.termIndex = 0;
        
    } else {
        
        self.termIndex = 1;
    }
    
    self.yearLable.text = [NSString stringWithFormat:@"%@年", self.yearArr[self.yearIndex]];
    self.termLable.text = self.termArr[self.termIndex];
    
    [self.pickView selectRow:self.termIndex inComponent:1 animated:NO];

    self.gradeView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getGradeInfo)];
    
    [self.gradeView.mj_header beginRefreshing];
}

- (void)getGradeInfo {
    
    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@grades/~self", MAINURL] params:nil success:^(id responseJSON) {
        
        self.allGradeArr = [MyGrade mj_objectArrayWithKeyValuesArray:responseJSON[@"courseScores"]];
        
        NSDictionary *dict = responseJSON[@"averageCredit"];
        self.averageCredit = dict[@"summary"];
        
        [self initTheCurrentScoreArr];
        
        [self.gradeView reloadData];
        [self.gradeView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.gradeView.mj_header endRefreshing];
    }];
}

- (void)initTheCurrentScoreArr {
    
    [self.currentGradeArr removeAllObjects];
    
    for (MyGrade *grade in self.allGradeArr) {
        
        if ([grade.year isEqualToString:self.yearArr[self.yearIndex]] && [grade.term isEqualToString:self.termArr[self.termIndex]]) {
            
            [self.currentGradeArr addObject:grade];
        }
    }
}

#pragma mark pickerView 代理方法 and 数据源

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return self.yearArr.count;
        
    } else {
        
        return self.termArr.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return [NSString stringWithFormat:@"%@年",self.yearArr[row]];
        
    } else {
        
        return [NSString stringWithFormat:@"%@",self.termArr[row]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        self.yearIndex = row;
        
        [self initTheCurrentScoreArr];
        [self.gradeView reloadData];
        
        self.yearLable.text = [NSString stringWithFormat:@"%@年", self.yearArr[self.yearIndex]];
        
    } else {
        
        self.termIndex = row;
        
        [self initTheCurrentScoreArr];
        [self.gradeView reloadData];
        
        self.termLable.text = self.termArr[self.termIndex];
    }
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSInteger x = ([[UIScreen mainScreen] bounds].size.width - 300)/2;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 8, 300, 25)];
    label.text = self.averageCredit;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.currentGradeArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PartGradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"part" forIndexPath:indexPath];

    cell.myGrade = self.currentGradeArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"grade2dtl" sender:self.currentGradeArr[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DetailGradeController *con = segue.destinationViewController;
    con.grade = sender;
}


- (IBAction)endEditing {
    
    CGRect pickerR = self.pickerDevice.frame;
    
    if (pickerR.origin.y >0) {
        
        pickerR.origin.y -= 165;
        
    } else {
        
        pickerR.origin.y += 165;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    self.pickerDevice.frame = pickerR;
    [UIView commitAnimations];
}


- (void)movePicker:(NSInteger)y {
    
    CGRect pickerR = self.pickerDevice.frame;
    pickerR.origin.y = y;
    self.pickerDevice.frame = pickerR;
}

@end
