//
//  OneKeyRateCell.m
//  eduadmin
//
//  Created by JieLee on 4/21/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import "OneKeyRateCell.h"
#import "Common.h"

@implementation OneKeyRateCell

- (void)setInfo:(RatingInfo *)info {
    
    _info = info;
    
    self.nameLabel.text = info.name;
    self.teacherLabel.text = info.teacher;
    
    if ([info.done isEqualToString:@"0"]) {
        self.statusLable.text = @"未评估";
        self.statusLable.textColor = [UIColor redColor];
    } else {
        
        self.statusLable.text = @"已评估";
        self.statusLable.textColor = LJColor(100, 157, 89);
    }
}

+ (instancetype)newOneKeyCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"OneKeyRateCell" owner:nil options:nil][0];
}

@end
