//
//  JWUnpassGrade.h
//  lntuApp
//
//  Created by 李杰 on 14/9/28.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnpassGrade : NSObject

@property (nonatomic,copy) NSString *num; // 课程编号
@property (nonatomic,copy) NSString *name; // 课程名
@property (nonatomic,copy) NSString *index; // 课序号
@property (nonatomic,copy) NSString *score; // 分数
@property (nonatomic,copy) NSString *credit; // 学分
@property (nonatomic,copy) NSString *creditPoint; // 学分绩点
@property (nonatomic,copy) NSString *selectType; // 选课属性
@property (nonatomic,copy) NSString *remarks; // 备注
@property (nonatomic,copy) NSString *examType; // 考试类型
@property (nonatomic,copy) NSString *semester; // 学年学期

@end
