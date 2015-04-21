//
//  DetailGradeController.m
//  教务处
//
//  Created by 李杰 on 14-8-20.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "DetailGradeController.h"
#import "MyGrade.h"
#import "UnpassGrade.h"

@interface DetailGradeController ()

@end

@implementation DetailGradeController

@synthesize arr;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    NSString *flag = arr[1];
//    
//    if ([flag isEqualToString:@"0"]) {
//        
//        MyGrade *grade = arr[0];
//        
//        NSString *i = [NSString stringWithFormat:@"%@",grade.index];
//        NSString *c = [NSString stringWithFormat:@"%@",grade.credit];
//        
//        self.num.text = grade.num;
//        self.name.text = grade.name;
//        self.index.text = i;
//        self.score.text = grade.score;
//        self.credit.text = c;
//        self.testMode.text = grade.testMode;
//        self.selectType.text = grade.selectType;
//        self.remarks.text = grade.remarks;
//        self.examType.text = grade.examType;
//        self.semester.text = grade.semester;
//        
//    }else if ([flag isEqualToString:@"1"]){
//        
//        UnpassGrade *unPassGrade = arr[0];
//        
//        NSString *i = [NSString stringWithFormat:@"%@",unPassGrade.index];
//        NSString *c = [NSString stringWithFormat:@"%@",unPassGrade.credit];
//        NSString *cp = [NSString stringWithFormat:@"%@",unPassGrade.creditPoint];
//        
//        self.num.text = unPassGrade.num;
//        self.name.text = unPassGrade.name;
//        self.index.text = i;
//        self.score.text = unPassGrade.score;
//        self.credit.text = c;
//        self.mLable.text = @"学分绩点";
//        self.testMode.text = cp;
//        self.selectType.text = unPassGrade.selectType;
//        self.remarks.text = unPassGrade.remarks;
//        self.examType.text = unPassGrade.examType;
//        self.semester.text = unPassGrade.semester;
//    }
    
    
    
}

@end
