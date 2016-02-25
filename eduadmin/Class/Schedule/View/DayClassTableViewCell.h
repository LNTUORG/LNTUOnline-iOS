//
//  DayClassTableViewCell.h
//  eduadmin
//
//  Created by Li Jie on 4/18/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayCourse.h"
#import "CourseLable.h"

@interface DayClassTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *timeInterval;

@property (nonatomic, strong) IBOutlet UILabel *time0;

@property (nonatomic, strong) IBOutlet UILabel *time1;

@property (nonatomic, strong) IBOutlet UILabel *time2;

@property (nonatomic, strong) IBOutlet UILabel *time3;

@property (nonatomic, strong) IBOutlet CourseLable *class0;

@property (nonatomic, strong) IBOutlet CourseLable *class1;

@property (nonatomic, strong) DayCourse *course;

@property (nonatomic, strong) NSString *course0;
@property (nonatomic, strong) NSString *course1;

@end
