//
//  SelfInfomation.m
//  eduadmin
//
//  Created by Li Jie on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "SelfInformation.h"
#import "MJExtension.h"
#import "EntranceExam.h"
#import "EducationExperience.h"
#import "Family.h"
#import "DisciplinaryActions.h"

@implementation SelfInformation

- (NSDictionary *)objectClassInArray {
    
    return @{@"entranceExams": [EntranceExam class], @"educationExperiences": [EducationExperience class], @"familys": [Family class], @"disciplinaryActions": [DisciplinaryActions class]};
}

@end
