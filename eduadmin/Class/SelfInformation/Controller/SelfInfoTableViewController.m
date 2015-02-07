//
//  SelfInfoTableViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "SelfInfoTableViewController.h"
#import "SelfInformation.h"
#import "EntranceExam.h"
#import "EducationExperience.h"
#import "Family.h"
#import "Title.h"
#import "MJExtension.h"
#import "familyCell.h"
#import "CellItem.h"
#import "HeaderView.h"
#import "LJTools.h"
#import "Common.h"
#import "MJRefresh.h"
#import "MBProgressHUD+LJ.h"

@interface SelfInfoTableViewController () <HeaderViewDelegate>

{
    NSArray *_basicInfoChinese; // 基本信息名
    NSArray *_titles; // 标题
    NSArray *_basicInfo; // 基本信息值
    SelfInformation *_imformation;
}

@end

@implementation SelfInfoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 50;
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData) dateKey:@"table"];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉进行刷新";
    self.tableView.headerReleaseToRefreshText = @"松开执行刷新";
    self.tableView.headerRefreshingText = @"正在刷新中...";
    
    NSArray *tempArr = @[@"基本信息",@"高考分数",@"教育经历",@"家庭成员"];
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSString *str in tempArr) {
        Title *ti = [Title titleWithString:str];
        [arr addObject:ti];
    }
    
    _titles = arr;
    
    _basicInfoChinese = @[@"学号",@"姓名",@"英文名",@"证件类型",@"证件号码",@"性别",@"院系",@"班级",@"考区",@"准考证号",@"外语",@"入学日期",@"毕业日期",@"家庭住址",@"联系电话",@"学籍表号",@"毕业去向",@"国籍",@"籍贯",@"生日",@"政治面貌",@"乘车区间",@"民族",@"专业",@"学生类别",@"高考总分",@"毕业院校",@"录取证号",@"入学方式",@"培养方式",@"邮政编码",@"电子邮箱",@"学生来源",@"备注"];
    
    
    NSString *filePath = [LJFileTool getFilePath:[self getAddress:selfInfoFileName]];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        [self analyticalData:dict];
        
    }else{
        [self refreshData];
    }
    
}


- (NSString *)getAddress:(NSString *)fileName {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [def objectForKey:userNameKey];
    
    if (str.length) {
        return [NSString stringWithFormat:@"%@%@",str,fileName];
    } else {
        return @"error";
    }
    
}

#pragma mark 刷新数据

- (void)refreshData
{
    
    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@student/info",sinaURL] params:nil success:^(id responseJSON) {
        [LJFileTool writeToFileContent:responseJSON withFileName:[self getAddress:selfInfoFileName]];
        [self analyticalData:responseJSON];
        [self.tableView headerEndRefreshing];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:errorStr];
        [self.tableView headerEndRefreshing];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark 解析数据
- (void)analyticalData:(id)json
{
    SelfInformation *student = [SelfInformation objectWithKeyValues:json];
    
    //基本信息
    _basicInfo = @[student.userId,student.name,student.englishName,student.idCardType,student.idCardNum,student.sex,student.college,student.classInfo,student.entranceExamArea,student.entranceExamNum,student.foreignLanguage,student.dateOfAdmission,student.dateOfGraduation,student.homeAddress,student.contactTel,student.studentInfoTableNum,student.whereaboutsAftergraduation,student.nationality,student.birthplace,student.dateOfBirth,student.politicalAffiliation,student.travelRange,student.nation,student.major,student.studentType,student.entranceExamScore,student.graduateSchool,student.admissionNum,student.admissionType,student.educationType,student.zipCode,student.email,student.sourceOfStudent,student.remarks];
    _imformation = student;
    
    NSString *filePath = [LJFileTool getFilePath:[self getAddress:selfIconFileName]];
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath:filePath]) {
        self.personalImg.image = [UIImage imageWithContentsOfFile:filePath];
    }else{
        [LJFileTool writeImageToFileName:[self getAddress:selfIconFileName] withImgURL:student.photoUrl];
        self.personalImg.image = [UIImage imageWithContentsOfFile:filePath];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Title *title = _titles[section];
    
    if (title.isOpen) {
        if (section == 0) return _basicInfo.count;
        if (section == 1) return _imformation.entranceExams.count;
        if (section == 2) return _imformation.educationExperiences.count * 2;
        else return _imformation.familys.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //标识
    static NSString *ID0 = @"cellItem";
    static NSString *ID1 = @"familyCell";
    
    
    //设置数据
    if (indexPath.section == 0) {
        
        //缓存池
        CellItem *studentInfo = [tableView dequeueReusableCellWithIdentifier:ID0];
        
        if (studentInfo == nil) {
            studentInfo = [CellItem newCellItem];
        }
        
        studentInfo.tName = _basicInfoChinese[indexPath.row];
        studentInfo.tValue = _basicInfo[indexPath.row];
        return studentInfo;
    }
    else if (indexPath.section == 1) {
        
        //缓存池
        CellItem *studentInfo = [tableView dequeueReusableCellWithIdentifier:ID0];
        
        if (studentInfo == nil) {
            studentInfo = [CellItem newCellItem];
        }
        
        
        EntranceExam *exam = _imformation.entranceExams[indexPath.row];
        
        studentInfo.tName =exam.name;
        studentInfo.tValue = exam.score;
        return studentInfo;
    }
    else if (indexPath.section == 2) {
        
        //缓存池
        CellItem *studentInfo = [tableView dequeueReusableCellWithIdentifier:ID0];
        
        if (studentInfo == nil) {
            studentInfo = [CellItem newCellItem];
        }
        
        NSInteger x = indexPath.row/2;
        NSInteger flag = indexPath.row%2;
        
        EducationExperience *e = _imformation.educationExperiences[x];
        if (flag == 0) {
            studentInfo.tName =e.dateOfStart;
            studentInfo.tValue = e.dateOfEnd;
        }else{
            studentInfo.tName =e.schoolName;
            studentInfo.tValue = e.witness;
        }
        return studentInfo;
        
    }
    else if (indexPath.section == 3) {
        
        //缓存池
        familyCell *studentInfo = [tableView dequeueReusableCellWithIdentifier:ID1];
        
        if (studentInfo == nil) {
            studentInfo = [familyCell  newFamilyCell];
        }
        
        Family *f = _imformation.familys[indexPath.row];
        
        studentInfo.tName =f.name;
        studentInfo.tRelationship = f.relationship;
        studentInfo.tPoliticalAffiliation = f.politicalAffiliation;
        studentInfo.tJob = f.job;
        studentInfo.tPost = f.post;
        studentInfo.tWorkLocation = f.workLocation;
        studentInfo.tTel = f.tel;
        return studentInfo;
    }
    else{
        
        //缓存池
        CellItem *studentInfo = [tableView dequeueReusableCellWithIdentifier:ID0];
        
        if (studentInfo == nil) {
            studentInfo = [CellItem newCellItem];
        }
        
        studentInfo.tName =@"error";
        studentInfo.tValue = @"error";
        return studentInfo;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
        return 142;
    else
        return 44;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderView *header = [HeaderView headerViewWithTableView:tableView];
    header.delegate = self;
    header.title = _titles[section];
    return header;
}

- (void)headerViewDidClickNameView:(HeaderView *)headerView
{
    [self.tableView reloadData];
}

@end
