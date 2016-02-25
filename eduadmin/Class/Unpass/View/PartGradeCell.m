//
//  PartGradeCell.m
//  教务处
//
//  Created by Li Jie on 14-8-20.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "PartGradeCell.h"
#import "UnpassGrade.h"
#import "MyGrade.h"
#import "Common.h"

@implementation PartGradeCell

- (void)setUnPassGrade:(UnpassGrade *)unPassGrade {
    
    _unPassGrade = unPassGrade;
    
    self.name.text = unPassGrade.name;
    self.credit.text = [NSString stringWithFormat:@"%2.1f", unPassGrade.credit];
    
    self.selectType.text = unPassGrade.selectType;
}

- (void)setMyGrade:(MyGrade *)myGrade {

    _myGrade = myGrade;
    
    self.name.text = myGrade.name;
    
    self.creditLable.text = @"成绩";
    
    self.credit.text = myGrade.score;
    
    if ([myGrade.level isEqualToString:@"GREAT"]) {
        
        self.credit.textColor = LJColor(100, 157, 89);
    }
    else if ([myGrade.level isEqualToString:@"NORMAL"]) {
        
        self.credit.textColor = [UIColor orangeColor];
    }
    else if ([myGrade.level isEqualToString:@"UNPASS"]) {
        
        self.credit.textColor = [UIColor redColor];
    }
    
    self.selectType.text = [NSString stringWithFormat:@"%@年%@", myGrade.year, myGrade.term];
}

@end
