//
//  PartGradeCell.h
//  教务处
//
//  Created by Li Jie on 14-8-20.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyGrade;
@class UnpassGrade;

@interface PartGradeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *creditLable;

@property (weak, nonatomic) IBOutlet UILabel *credit;

@property (weak, nonatomic) IBOutlet UILabel *selectType;

@property (nonatomic, strong) MyGrade *myGrade;
@property (nonatomic, strong) UnpassGrade *unPassGrade;

+ (instancetype)newPartGradeCell;


@end
