//
//  HeaterTempCell.h
//  eduadmin
//
//  Created by Li Jie on 15/5/29.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaterTempCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *locateLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *tempLabel;

@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@property (nonatomic, copy) NSArray *info;
@end
