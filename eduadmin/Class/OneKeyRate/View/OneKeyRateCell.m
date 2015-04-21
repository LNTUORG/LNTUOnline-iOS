//
//  OneKeyRateCell.m
//  eduadmin
//
//  Created by JieLee on 4/21/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import "OneKeyRateCell.h"

@implementation OneKeyRateCell

- (void)setInfo:(RatingInfo *)info {
    
    _info = info;
    
    self.nameLabel.text = info.course;
    self.teacherLabel.text = info.teacher;
    self.statusLable.text = info.state;
    
    if ([info.state isEqualToString:@"已评估"]) {
        
        self.statusLable.textColor = [UIColor greenColor];
    }
}

+ (instancetype)newOneKeyCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"OneKeyRateCell" owner:nil options:nil][0];
}

@end
