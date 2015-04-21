//
//  DetailGradeController.m
//  教务处
//
//  Created by 李杰 on 14-8-20.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "DetailGradeController.h"
#import "MyGrade.h"

@interface DetailGradeController ()

@end

@implementation DetailGradeController

@synthesize grade;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

        
    NSString *i = [NSString stringWithFormat:@"%@",grade.serialNum];
    NSString *c = [NSString stringWithFormat:@"%2.1f",grade.credit];
    
    NSString *s = [NSString stringWithFormat:@"%@年%@", grade.year, grade.term];
    
    self.num.text = grade.num;
    self.name.text = grade.name;
    self.index.text = i;
    self.score.text = grade.score;
    self.credit.text = c;
    self.testMode.text = grade.testMode;
    self.selectType.text = grade.selectType;
    self.remarks.text = grade.remarks;
    self.examType.text = grade.examType;
    self.semester.text = s;
}

@end
