//
//  LocationTableViewCell.m
//  eduadmin
//
//  Created by JieLee on 15/5/14.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "SchoolLocationCell.h"

@implementation SchoolLocationCell

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    self.backgroundImage.image = [UIImage imageNamed:imageName];
}

- (void)setSchoolName:(NSString *)schoolName {
    
    _schoolName = schoolName;
    self.schoolNameLabel.text = schoolName;
}

+ (instancetype)newLocationCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"LocationTableViewCell" owner:nil options:nil][0];
}

@end
