//
//  DetailGradeCell.m
//  eduadmin
//
//  Created by JieLee on 4/21/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import "DetailGradeCell.h"

@implementation DetailGradeCell

- (void)setRecords:(UnpassGradeRecord *)records {
    
    _records = records;
    self.score.text = records.score;
    self.score.textColor = [UIColor redColor];
    
    self.examType.text = records.examType;
    self.term.text = records.term;
    self.year.text = records.year;
    self.remark.text = records.remarks;
}

+ (instancetype)newDetailGradeCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"DetailGradeCell" owner:nil options:nil][0];
}

@end
