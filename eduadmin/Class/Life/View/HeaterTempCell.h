//
//  HeaterTempCell.h
//  eduadmin
//
//  Created by JieLee on 15/5/29.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaterTempCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *locateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@property (strong, nonatomic) NSArray *info;

+ (instancetype)newHeaterTempCell;

@end
