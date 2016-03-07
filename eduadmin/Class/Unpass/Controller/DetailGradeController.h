//
//  DetailGradeController.h
//  教务处
//
//  Created by Li Jie on 14-8-20.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyGrade;

@interface DetailGradeController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *num;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *index;

@property (strong, nonatomic) IBOutlet UILabel *score;

@property (strong, nonatomic) IBOutlet UILabel *credit;

@property (strong, nonatomic) IBOutlet UILabel *testMode;

@property (strong, nonatomic) IBOutlet UILabel *remarks;

@property (strong, nonatomic) IBOutlet UILabel *examType;

@property (strong, nonatomic) IBOutlet UILabel *semester;

@property (strong, nonatomic) IBOutlet UILabel *mLable;

@property (nonatomic, strong) MyGrade *grade;

@end
