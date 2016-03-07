//
//  JWUnpassGrade.h
//  lntuApp
//
//  Created by Li Jie on 14/9/28.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnpassGrade : NSObject

@property (nonatomic, copy) NSString *num; // 课程编号
@property (nonatomic, copy) NSString *name; // 课程名
@property (nonatomic, copy) NSString *serialNum; // 课序号
@property (nonatomic, assign) float credit; // 学分
@property (nonatomic, copy) NSString *selectType; // 选课属性

@property (nonatomic, copy) NSArray *records;

@end
