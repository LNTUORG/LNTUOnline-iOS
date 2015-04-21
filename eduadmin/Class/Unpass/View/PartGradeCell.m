//
//  PartGradeCell.m
//  教务处
//
//  Created by 李杰 on 14-8-20.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "PartGradeCell.h"
#import "UnpassGrade.h"
#import "MyGrade.h"

@implementation PartGradeCell

- (void)setUnPassGrade:(UnpassGrade *)unPassGrade
{
    _unPassGrade = unPassGrade;
    
    self.name.text = unPassGrade.name;
    self.credit.text = unPassGrade.credit;
    
    self.selectType.text = unPassGrade.selectType;
}

//- (void)setGrade:(MyGrade *)grade
//{
//    _grade = grade;
//    
//    if ([grade.score isEqualToString:@"良"]||[grade.score isEqualToString:@"中"]||[grade.score isEqualToString:@"及格"]||[grade.score isEqualToString:@"合格"]||[grade.score isEqualToString:@"优秀"]) {
//        self.score.textColor = [UIColor orangeColor];
//    }else if ([grade.score intValue] < 60) {
//        self.score.textColor = [UIColor redColor];
//    }else if([grade.score intValue] <= 80){
//        self.score.textColor = [UIColor orangeColor];
//    }else{
//        self.score.textColor = [UIColor greenColor];
//    }
//    
//    self.name.text = grade.name;
//    self.score.text = grade.score;
//    self.year.text = grade.semester;
//
//}

+ (instancetype)newPartGradeCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"PartGradeCell" owner:nil options:nil][0];
}

@end
