//
//  OneKeyRateCell.h
//  eduadmin
//
//  Created by Li Jie on 4/21/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingInfo.h"

@interface OneKeyRateCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *teacherLabel;

@property (strong, nonatomic) IBOutlet UILabel *statusLable;

@property (nonatomic, strong) RatingInfo *info;
@end
