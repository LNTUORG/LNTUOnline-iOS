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
#import "SelfInfoTableViewCell.h"
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
    
    UIImage *originImage = [UIImage imageNamed:@"bgimage"];
    
    UIImage *newImage = [LJUITool imageWithImage:originImage scaledToSize:self.tableView.tableHeaderView.frame.size];
    
    self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithPatternImage:newImage];
    
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
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
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
        
        if (section == 0) {
            
            return self.basicInfoValue.count;
        }
        if (section == 1) {
        
            return self.information.entranceExams.count;
        }
        if (section == 2) {
        
            return self.information.educationExperiences.count;
        }
        if (section == 3) {
        
            return self.information.familys.count;
            
        } else {
            
            return self.information.disciplinaryActions.count;
        }
    } else {
        
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //标识
    static NSString *normalIdentifier = @"InfoNormalCell";
    static NSString *eduIdentifier = @"InfoEduCell";
    static NSString *familyIdentifier = @"InfoFamilyCell";
    
    switch (indexPath.section) {
        case 0: {
            
            SelfInfoNormalTableViewCell *studentInfo = [tableView dequeueReusableCellWithIdentifier:normalIdentifier forIndexPath:indexPath];
            studentInfo.keyLabel.text = self.basicInfoKey[indexPath.row];
            studentInfo.valueLabel.text = self.basicInfoValue[indexPath.row];
            return studentInfo;
            break;
        }
        case 1: {
            EntranceExam *exam = _information.entranceExams[indexPath.row];
            SelfInfoNormalTableViewCell *examCell = [tableView dequeueReusableCellWithIdentifier:normalIdentifier forIndexPath:indexPath];
            examCell.keyLabel.text = exam.name;
            examCell.valueLabel.text = exam.score;
            return examCell;
            break;
        }
        case 2: {
            EducationExperience *edu = _information.educationExperiences[indexPath.row];
            SelfInfoEduTableViewCell *eduCell = [tableView dequeueReusableCellWithIdentifier:eduIdentifier forIndexPath:indexPath];
            eduCell.startTimeLabel.text = [self transDateToString:edu.startTime];
            eduCell.endTimeLabel.text = [self transDateToString:edu.endTime];
            eduCell.schoolInfoLabel.text = edu.schoolInfo;
            eduCell.witnessLabel.text = edu.witness;
            return eduCell;
            break;
        }
        case 3: {
            Family *family = _information.familys[indexPath.row];
            SelfInfoFamilyTableViewCell * familyCell = [tableView dequeueReusableCellWithIdentifier:familyIdentifier forIndexPath:indexPath];
            familyCell.nameLabel.text = [NSString stringWithFormat:@"%@（%@）", family.name, family.relationship];
            familyCell.politicalAffiliationLabel.text = family.politicalAffiliation;
            familyCell.jobLabel.text = [NSString stringWithFormat:@"%@  %@", family.job, family.post];
            familyCell.workLocationLabel.text = family.workLocation;
            familyCell.phoneLabel.text = family.tel;
            return familyCell;
            break;
        }
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return 60;
            break;
        case 1:
            return 60;
            break;
        case 2:
            return 78;
            break;
        case 3:
            return 120;
            break;
        default:
            return 60;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HeaderView *header = [HeaderView headerViewWithTableView:tableView];
    header.delegate = self;
    header.title = _titles[section];
    header.section = section;
    
    return header;
}

- (void)headerViewDidClickNameView:(HeaderView *)headerView {
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:headerView.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSString *)transDateToString:(NSString *)date {
    
    NSArray *arr = [date.description componentsSeparatedByString:@"T"];
    
    return arr[0];
}

@end
