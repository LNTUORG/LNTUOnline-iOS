//
//  WeekLable.m
//  eduadmin
//
//  Created by Li Jie on 9/7/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import "WeekLable.h"

@implementation WeekLable

- (void)setText:(NSString *)text {
    [super setText:text];
    
    if ([text isEqualToString:@""]) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    if ([[[text componentsSeparatedByString:@"\n"] lastObject] isEqualToString:@"未开课"]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

@end
