//
//  EducationExperience.h
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EducationExperience : NSObject

@property (nonatomic, strong) NSDate *startTime; // 开始日期
@property (nonatomic, strong) NSDate *endTime; // 终止日期
@property (nonatomic, copy) NSString *schoolInfo; // 学校名
@property (nonatomic, copy) NSString *witness; // 班主任

@end
