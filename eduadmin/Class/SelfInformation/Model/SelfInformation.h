//
//  SelfInfomation.h
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelfInformation : NSObject

@property (nonatomic, copy) NSString *userId; // 学号
@property (nonatomic, copy) NSString *name; // 姓名
@property (nonatomic, copy) NSString *englishName; // 英文名
@property (nonatomic, copy) NSString *idCardType; // 证件类型
@property (nonatomic, copy) NSString *idCardNum; // 证件号码
@property (nonatomic, copy) NSString *sex; // 性别
@property (nonatomic, copy) NSString *college; // 学院
@property (nonatomic, copy) NSString *classInfo; // 班级
@property (nonatomic, copy) NSString *entranceExamArea; // 考区
@property (nonatomic, copy) NSString *entranceExamNum; // 准考证号
@property (nonatomic, copy) NSString *foreignLanguage; // 外语语种
@property (nonatomic, strong) NSDate *admissionTime; // 入学日期
@property (nonatomic, strong) NSDate *graduationTime; // 毕业日期
@property (nonatomic, copy) NSString *homeAddress; // 家庭住址
@property (nonatomic, copy) NSString *tel; // 联系电话
@property (nonatomic, copy) NSString *studentInfoTableNum; // 学籍表号
@property (nonatomic, copy) NSString *whereaboutsAftergraduation; // 毕业去向
@property (nonatomic, copy) NSString *nationality; // 国籍
@property (nonatomic, copy) NSString *birthplace; // 籍贯
@property (nonatomic, strong) NSDate *birthday; // 生日
@property (nonatomic, copy) NSString *politicalAffiliation; // 政治面貌
@property (nonatomic, copy) NSString *travelRange; // 乘车区间
@property (nonatomic, copy) NSString *nation; // 民族
@property (nonatomic, copy) NSString *major; // 专业
@property (nonatomic, copy) NSString *studentType; // 学生类别
@property (nonatomic, copy) NSString *entranceExamScore; // 高考总分
@property (nonatomic, copy) NSString *graduateSchool; // 毕业院校
@property (nonatomic, copy) NSString *admissionNum; // 录取证号
@property (nonatomic, copy) NSString *admissionType; // 入学方式
@property (nonatomic, copy) NSString *educationType; // 培养方式
@property (nonatomic, copy) NSString *zipCode; // 邮政编码
@property (nonatomic, copy) NSString *email; // 电子邮箱
@property (nonatomic, copy) NSString *sourceOfStudent; // 学生来源
@property (nonatomic, copy) NSString *remarks; // 备注
@property (nonatomic, copy) NSString *photoUrl; // 照片 URL

@property (nonatomic, strong) NSArray *entranceExams; // 高考分数
@property (nonatomic, strong) NSArray *educationExperiences; // 教育经历
@property (nonatomic, strong) NSArray *familys; // 家庭成员
@property (nonatomic, strong) NSArray *disciplinaryActions; // 惩处信息
@end
