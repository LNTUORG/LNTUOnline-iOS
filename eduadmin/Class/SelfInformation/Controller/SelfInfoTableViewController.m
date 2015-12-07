//
//  SelfInfoTableViewController.m
//  eduadmin
//
//  Created by Li Jie on 14/12/31.
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
#import "DisciplinaryActions.h"

@interface SelfInfoTableViewController () <HeaderViewDelegate>

@end

@implementation SelfInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 50;
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    NSArray *tempArr = @[@"基本信息", @"高考科目", @"个人简历", @"家庭情况"];
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSString *str in tempArr) {
        
        Title *ti = [Title titleWithString:str];
        [arr addObject:ti];
    }
    
    self.titles = arr;
    
    self.basicInfoKey = @[@"学号", @"姓名", @"英文名", @"证件类型", @"证件号码", @"性别", @"院系", @"班级", @"考区", @"准考证号", @"外语", @"入学日期", @"毕业日期", @"家庭住址", @"联系电话", @"学籍表号", @"毕业去向", @"国籍", @"籍贯", @"生日", @"政治面貌", @"乘车区间", @"民族", @"专业", @"学生类别", @"高考总分", @"毕业院校", @"录取证号", @"入学方式", @"培养方式", @"邮政编码", @"电子邮箱", @"学生来源", @"备注"];
    
    self.disActKey = @[@"处分等级", @"处分日期", @"处分原因", @"撤销原因", @"状态", @"备注"];
    
    NSString *filePath = [LJFileTool getFilePath:selfInfoFileName];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        [self analyticalData:dict];
        
    } else {
        
        [self refreshData];
    }
}


- (void)refreshData {
    
    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@student/~self", MAINURL] params:nil success:^(id responseJSON) {
        
        [LJFileTool writeToFileContent:responseJSON withFileName:selfInfoFileName];
        
        [self analyticalData:responseJSON];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}


- (void)analyticalData:(id)json {
    SelfInformation *student = [SelfInformation mj_objectWithKeyValues:json];
    
    //基本信息
    self.basicInfoValue = @[json[@"id"], student.name, student.englishName, student.idCardType, student.idCardNum, student.sex, student.college, student.classInfo, student.entranceExamArea, student.entranceExamNum, student.foreignLanguage, [self transDateToString:student.admissionTime], [self transDateToString: student.graduationTime], student.homeAddress, student.tel, student.studentInfoTableNum, student.whereaboutsAftergraduation, student.nationality, student.birthplace, [self transDateToString:student.birthday], student.politicalAffiliation, student.travelRange, student.nation, student.major, student.studentType, student.entranceExamScore, student.graduateSchool, student.admissionNum, student.admissionType, student.educationType, student.zipCode, student.email, student.sourceOfStudent, student.remarks];
    
    self.information = student;
    
    NSString *filePath = [LJFileTool getFilePath:selfIconFileName];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        
        self.personalImg.image = [UIImage imageWithContentsOfFile:filePath];
        
    } else {
        
        [LJFileTool writeImageToFileName:selfIconFileName withImgURL:student.photoUrl];
        self.personalImg.image = [UIImage imageWithContentsOfFile:filePath];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Title *title = _titles[section];
    
    if (title.isOpen) {
        
        if (section == 0) return self.basicInfoValue.count;
        if (section == 1) return self.information.entranceExams.count;
        if (section == 2) return self.information.educationExperiences.count * 2;
        if (section == 3) return self.information.familys.count;
        else return self.information.disciplinaryActions.count;
        
    } else {
        
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //标识
    static NSString *ID0 = @"cellItem";
    static NSString *ID1 = @"familyCell";
    
    //设置数据
    if (indexPath.section == 0) {
        
        //缓存池
        CellItem *studentInfo = [tableView dequeueReusableCellWithIdentifier:ID0];
        
        if (!studentInfo) {
            
            studentInfo = [CellItem newCellItem];
        }
        
        studentInfo.tName = self.basicInfoKey[indexPath.row];
        studentInfo.tValue = self.basicInfoValue[indexPath.row];
        return studentInfo;
    }
    else if (indexPath.section == 1) {
        
        //缓存池
        CellItem *studentInfo = [tableView dequeueReusableCellWithIdentifier:ID0];
        
        if (!studentInfo) {
            
            studentInfo = [CellItem newCellItem];
        }
        
        EntranceExam *exam = _information.entranceExams[indexPath.row];
        
        studentInfo.tName =exam.name;
        studentInfo.tValue = exam.score;
        return studentInfo;
    }
    else if (indexPath.section == 2) {
        
        //缓存池
        CellItem *studentInfo = [tableView dequeueReusableCellWithIdentifier:ID0];
        
        if (!studentInfo) {
            
            studentInfo = [CellItem newCellItem];
        }
        
        NSInteger x = indexPath.row/2;
        NSInteger flag = indexPath.row%2;
        
        EducationExperience *e = _information.educationExperiences[x];
        
        if (flag == 0) {
            
            studentInfo.tName = [self transDateToString:e.startTime];
            studentInfo.tValue = [self transDateToString:e.endTime];
            
        } else {
            
            studentInfo.tName =e.schoolInfo;
            studentInfo.tValue = e.witness;
        }
        
        return studentInfo;
    }
    else if (indexPath.section == 3) {
        
        //缓存池
        familyCell *studentInfo = [tableView dequeueReusableCellWithIdentifier:ID1];
        
        if (!studentInfo) {
            
            studentInfo = [familyCell  newFamilyCell];
        }
        
        Family *f = _information.familys[indexPath.row];
        
        studentInfo.tName =f.name;
        studentInfo.tRelationship = f.relationship;
        studentInfo.tPoliticalAffiliation = f.politicalAffiliation;
        studentInfo.tJob = f.job;
        studentInfo.tPost = f.post;
        studentInfo.tWorkLocation = f.workLocation;
        studentInfo.tTel = f.tel;
        return studentInfo;
        
    } else {
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3)
        return 130;
    else
        return 44;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HeaderView *header = [HeaderView headerViewWithTableView:tableView];
    header.delegate = self;
    header.title = _titles[section];
    
    return header;
}

- (void)headerViewDidClickNameView:(HeaderView *)headerView {
    
    [self.tableView reloadData];
}

- (NSString *)transDateToString:(NSString *)date {
    
    NSArray *arr = [date.description componentsSeparatedByString:@"T"];
    
    return arr[0];
}

@end
