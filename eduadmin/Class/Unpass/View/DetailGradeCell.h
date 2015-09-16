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

@property (weak, nonatomic) IBOutlet UILabel *score;

@property (weak, nonatomic) IBOutlet UILabel *examType;

@property (weak, nonatomic) IBOutlet UILabel *term;

@property (weak, nonatomic) IBOutlet UILabel *year;

@property (weak, nonatomic) IBOutlet UILabel *remark;


@property (nonatomic, strong) UnpassGradeRecord *records;

+ (instancetype)newDetailGradeCell;

@end
