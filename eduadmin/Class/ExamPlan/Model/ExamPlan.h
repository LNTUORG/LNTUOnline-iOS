//
//  JWExamPlan.h
//  lntuApp
//
//  Created by 李杰 on 14/10/2.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamPlan : NSObject

@property (nonatomic,copy) NSString *course;
@property (nonatomic,copy) NSString *startTime;
@property (nonatomic,copy) NSString *endTime;
@property (nonatomic,copy) NSString *location;

@end
