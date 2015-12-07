//
//  CircleHeadImageView.m
//  eduadmin
//
//  Created by Li Jie on 12/7/15.
//  Copyright © 2015 PUPBOSS. All rights reserved.
//

#import "CircleHeadImageView.h"
#import "UIImage+LJ.h"

@implementation CircleHeadImageView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.image = [UIImage imageNamed:@"avatar"];
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 3.0f;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}

@end
