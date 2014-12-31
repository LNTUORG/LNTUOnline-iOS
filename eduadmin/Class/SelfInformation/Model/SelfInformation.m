//
//  SelfInfomation.m
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "SelfInformation.h"
#import "MJExtension.h"
#import "EntranceExam.h"
#import "EducationExperience.h"
#import "Family.h"

@implementation SelfInformation

- (NSDictionary *)objectClassInArray
{
    return @{@"entranceExams" : [EntranceExam class],@"educationExperiences" : [EducationExperience class],@"familys" : [Family class]};
}

@end