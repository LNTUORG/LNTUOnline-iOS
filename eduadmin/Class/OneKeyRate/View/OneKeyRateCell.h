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

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLable;

@property (strong, nonatomic) RatingInfo *info;
@end
