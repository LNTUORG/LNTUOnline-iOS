//
//  ExamPlanCell.h
//  教务处
//
//  Created by Li Jie on 14-9-4.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExamPlan;

@interface ExamPlanCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextView *timeTextView;

@property (strong, nonatomic) IBOutlet UILabel *courseLable;

@property (strong, nonatomic) IBOutlet UILabel *locationLable;

@property (strong, nonatomic) IBOutlet UIButton *countDate;

@property (nonatomic, strong) ExamPlan *plan;
@end
