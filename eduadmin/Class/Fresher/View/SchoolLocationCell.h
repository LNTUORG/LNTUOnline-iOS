//
//  LocationTableViewCell.h
//  eduadmin
//
//  Created by JieLee on 15/5/14.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolLocationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;

@property (copy, nonatomic) NSString *imageName;

@property (copy, nonatomic) NSString *schoolName;

+ (instancetype)newLocationCell;

@end
