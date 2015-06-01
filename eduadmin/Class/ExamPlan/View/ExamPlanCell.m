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
    
    NSArray *arr = [plan.startTime componentsSeparatedByString:@"-"];
    
    NSArray *arr2 = [arr[2] componentsSeparatedByString:@"T"];
    
    NSArray *arr3 = [arr2[1] componentsSeparatedByString:@"."];
    
    NSArray *arr4 = [plan.endTime componentsSeparatedByString:@"T"];
    
    NSArray *arr5 = [arr4[1] componentsSeparatedByString:@"."];
    
    NSArray *arr6 = [arr3[0] componentsSeparatedByString:@":"];
    
    NSArray *arr7 = [arr5[0] componentsSeparatedByString:@":"];
    
    NSString *str = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@-%@:%@", arr[0], arr[1], arr2[0], arr6[0], arr6[1], arr7[0], arr7[1]];
    
    
    NSString *date = [NSString stringWithFormat:@"%@-%@-%@", arr[0], arr[1], arr2[0]];
    // 剩余天数
    NSString *lastDay = [NSString stringWithFormat:@"%d",[LJTimeTool dayNumberSinceDateWithFormat_yyyy_MM_dd:date]];
    

    if ([lastDay intValue]<=0) {
        lastDay = @"...";
        [self.countDate setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    [self.countDate setTitle:lastDay forState:UIControlStateNormal];
    
    self.timeTextView.text = str;
    self.courseLable.text = plan.course;
    self.locationLable.text = plan.location;
}


+ (id)newExanPlanCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"ExamPlanCell" owner:nil options:nil][0];
}

@end
