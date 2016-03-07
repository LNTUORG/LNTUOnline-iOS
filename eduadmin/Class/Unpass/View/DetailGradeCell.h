//
//  DetailGradeCell.h
//  eduadmin
//
//  Created by Li Jie on 4/21/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnpassGradeRecord.h"

@interface DetailGradeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *score;

@property (strong, nonatomic) IBOutlet UILabel *examType;

@property (strong, nonatomic) IBOutlet UILabel *term;

@property (strong, nonatomic) IBOutlet UILabel *year;

@property (strong, nonatomic) IBOutlet UILabel *remark;


@property (nonatomic, strong) UnpassGradeRecord *records;

@end
