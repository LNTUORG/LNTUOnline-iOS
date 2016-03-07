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

@property (strong, nonatomic) IBOutlet UILabel *courseLable;

@property (strong, nonatomic) IBOutlet UILabel *timeLable;

@property (strong, nonatomic) IBOutlet UIButton *countButton;

@property (nonatomic, strong) SkillTest *sTest;
@end
