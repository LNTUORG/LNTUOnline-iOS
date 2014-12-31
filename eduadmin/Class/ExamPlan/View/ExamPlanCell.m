//
//  ExamPlanCell.m
//  教务处
//
//  Created by 李杰 on 14-9-4.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "ExamPlanCell.h"
#import "ExamPlan.h"
#import "SkillTest.h"
#import "LJTools.h"

@implementation ExamPlanCell

- (void)setPlan:(ExamPlan *)plan
{
    _plan = plan;
    
    NSArray *arr = [plan.time componentsSeparatedByString:@"-"];
    NSArray *day = [arr[2] componentsSeparatedByString:@" "];
    NSString *str = [NSString stringWithFormat:@"%@月%@日 %@-%@",arr[1],day[0],day[1],arr[4]];
    
    NSArray *date = [plan.time componentsSeparatedByString:@" "];
    int lastDay = [LJTimeTool dayNumberSinceDateWithFormat_yyyy_MM_dd:date[0]];
    
    if (lastDay<0) {
        lastDay = 0;
    }
    
    [self.countDate setTitle:[NSString stringWithFormat:@"%d",lastDay] forState:UIControlStateNormal];
    
    self.timeTextView.text = str;
    self.courseLable.text = plan.course;
    self.locationLable.text = plan.location;
}


+ (id)newExanPlanCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"ExamPlanCell" owner:nil options:nil][0];
}

@end
