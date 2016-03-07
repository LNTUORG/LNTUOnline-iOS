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

@property (strong, nonatomic) IBOutlet UILabel *timeInterval;

@property (strong, nonatomic) IBOutlet UILabel *time0;

@property (strong, nonatomic) IBOutlet UILabel *time1;

@property (strong, nonatomic) IBOutlet UILabel *time2;

@property (strong, nonatomic) IBOutlet UILabel *time3;

@property (strong, nonatomic) IBOutlet CourseLable *class0;

@property (strong, nonatomic) IBOutlet CourseLable *class1;

@property (nonatomic, strong) DayCourse *course;

@property (nonatomic, copy) NSString *course0;
@property (nonatomic, copy) NSString *course1;

@end
