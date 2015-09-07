//
//  Family.h
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Family : NSObject

@property (nonatomic, copy) NSString *name; // 姓名
@property (nonatomic, copy) NSString *relationship; // 关系
@property (nonatomic, copy) NSString *politicalAffiliation; // 政治面貌
@property (nonatomic, copy) NSString *job; // 工作
@property (nonatomic, copy) NSString *post; // 职位
@property (nonatomic, copy) NSString *workLocation; // 工作地点
@property (nonatomic, copy) NSString *tel; // 联系电话

@end
