//
//  EducationExperience.h
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EducationExperience : NSObject

@property (nonatomic,copy) NSString *dateOfStart; // 开始日期
@property (nonatomic,copy) NSString *dateOfEnd; // 终止日期
@property (nonatomic,copy) NSString *schoolName; // 学校名
@property (nonatomic,copy) NSString *witness; // 班主任

@end
