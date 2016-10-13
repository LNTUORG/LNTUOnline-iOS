//
//  NightClassTableViewCell.m
//  eduadmin
//
//  Created by Li Jie on 4/18/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import "NightClassTableViewCell.h"

@implementation NightClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.courseLable.numberOfLines = 0;
}

- (void)setCourse:(NSString *)course {
    
    _course = course;
    self.courseLable.text = course;
}

@end
