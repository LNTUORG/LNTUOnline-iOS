//
//  DetailGradeController.h
//  教务处
//
//  Created by 李杰 on 14-8-20.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyGrade;
@class UnPassGrade;

@interface DetailGradeController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *num;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *index;

@property (weak, nonatomic) IBOutlet UILabel *score;

@property (weak, nonatomic) IBOutlet UILabel *credit;

@property (weak, nonatomic) IBOutlet UILabel *testMode;

@property (weak, nonatomic) IBOutlet UILabel *selectType;

@property (weak, nonatomic) IBOutlet UILabel *remarks;

@property (weak, nonatomic) IBOutlet UILabel *examType;

@property (weak, nonatomic) IBOutlet UILabel *semester;

@property (weak, nonatomic) IBOutlet UILabel *mLable;

@property (nonatomic,strong) NSArray *arr;


@end
