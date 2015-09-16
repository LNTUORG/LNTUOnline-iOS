//
//  JWSkillTest.m
//  lntuApp
//
//  Created by Li Jie on 14/12/26.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "SkillTestCell.h"
#import "SkillTest.h"

@implementation SkillTestCell



- (void)setSTest:(SkillTest *)sTest
{
    _sTest = sTest;
    
    self.courseLable.text = sTest.name;
    self.timeLable.text = sTest.time;
    
    [self.countButton setTitle:sTest.score forState:UIControlStateNormal];
}

+ (instancetype)newSkillTestCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"SkillTestCell" owner:nil options:nil][0];
}

@end
