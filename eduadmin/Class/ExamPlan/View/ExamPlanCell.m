//
//  ExamPlanCell.m
//  教务处
//
//  Created by Li Jie on 14-9-4.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "ExamPlanCell.h"
#import "ExamPlan.h"
#import "SkillTest.h"
#import "LJTools.h"
#import "Common.h"

@implementation ExamPlanCell

- (void)setPlan:(ExamPlan *)plan {
    
    _plan = plan;
    
    NSArray *arr = [plan.startTime componentsSeparatedByString:@"-"];
    
    NSArray *arr2 = [arr[2] componentsSeparatedByString:@"T"];
    
    NSArray *arr3 = [arr2[1] componentsSeparatedByString:@"."];
    
    NSArray *arr4 = [plan.endTime componentsSeparatedByString:@"T"];
    
    NSArray *arr5 = [arr4[1] componentsSeparatedByString:@"."];
    
    NSArray *arr6 = [arr3[0] componentsSeparatedByString:@":"];
    
    NSArray *arr7 = [arr5[0] componentsSeparatedByString:@":"];
    
    NSString *str = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@-%@:%@", arr[0], arr[1], arr2[0], arr6[0], arr6[1], arr7[0], arr7[1]];
    
    NSString *date = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", arr[0], arr[1], arr2[0], arr6[0], arr6[1]];
    
    // 剩余小时
    NSInteger baseHour = [LJTimeTool hourNumberSinceDateWithFormat_yyyy_MM_dd_HH_mm:date];
    
    NSString *lastDay = @"";
    
    [self.countDate setBackgroundColor:LJColor(134, 169, 111)];
    [self.countDate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (baseHour < 0) {
        
        lastDay = @"...";
        [self.countDate setBackgroundColor:[UIColor lightGrayColor]];
    }
    else if (baseHour > 0 && baseHour < 24) {
    
        lastDay = @"<1";
        [self.countDate setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else if (baseHour > 24 && baseHour < 48) {
        
        lastDay = [NSString stringWithFormat:@"%d", (int)(baseHour/24.00 + 0.5)];
        [self.countDate setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    } else {
        
        lastDay = [NSString stringWithFormat:@"%d", (int)(baseHour/24.00 + 0.5)];
    }
    
    [self.countDate setTitle:lastDay forState:UIControlStateNormal];
    
    self.timeTextView.text = str;
    self.courseLable.text = plan.course;
    self.locationLable.text = plan.location;
}

@end
