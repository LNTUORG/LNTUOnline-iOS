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

@property (weak, nonatomic) IBOutlet UITextView *timeTextView;

@property (weak, nonatomic) IBOutlet UILabel *courseLable;

@property (weak, nonatomic) IBOutlet UILabel *locationLable;

@property (weak, nonatomic) IBOutlet UIButton *countDate;

@property (nonatomic,strong) ExamPlan *plan;

+ (id)newExanPlanCell;

@end
