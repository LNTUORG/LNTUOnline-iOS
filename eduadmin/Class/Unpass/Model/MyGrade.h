//
//  MyGrade.h
//  教务处
//
//  Created by 李杰 on 14-8-13.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyGrade : NSObject

@property (nonatomic, copy) NSString *num; // 课程编号
@property (nonatomic, copy) NSString *name; // 课程名
@property (nonatomic, copy) NSString *serialNum; // 课序号
@property (nonatomic, copy) NSString *score; // 分数
@property (nonatomic, assign) float credit; // 学分
@property (nonatomic, copy) NSString *testMode; // 考核方式
@property (nonatomic, copy) NSString *selectType; // 选课属性
@property (nonatomic, copy) NSString *remarks; // 备注
@property (nonatomic, copy) NSString *examType; // 考试性质
@property (nonatomic, copy) NSString *term;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *level;

@end
