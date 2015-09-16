//
//  JWSkillTest.h
//  lntuApp
//
//  Created by Li Jie on 14/12/26.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SkillTest;

@interface SkillTestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *courseLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UIButton *countButton;

@property (nonatomic,strong) SkillTest *sTest;

+ (instancetype)newSkillTestCell;

@end
