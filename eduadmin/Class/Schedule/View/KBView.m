//
//  KBView.m
//  PageScroll-Demo
//
//  Created by JieLee on 15/3/27.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "KBView.h"
#import "UIView+Autolayout.h"

@implementation KBView

- (instancetype)initWithArr:(NSArray *)KBArr {
    
    if (self = [super init]) {
        
        UILabel *one = [UILabel autolayoutView];
        
        UILabel *two = [UILabel autolayoutView];
        
        UILabel *three = [UILabel autolayoutView];
        
        UILabel *four = [UILabel autolayoutView];
        
        UILabel *five = [UILabel autolayoutView];
        
        
        NSInteger labelNumber = 0;
        for (UILabel *lable in @[one, two, three, four, five]) {
            
            lable.text = KBArr[labelNumber++];
            lable.font = [UIFont systemFontOfSize:14];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.numberOfLines = 0;
            [self addSubview:lable];
        }
        
        NSInteger screenWidth = [[UIScreen mainScreen] bounds].size.width / 2;
        
        NSDictionary *metrics = @{@"height":@(screenWidth)};
        NSDictionary *views = NSDictionaryOfVariableBindings(one, two, three, four, five);
        
        NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[one(two)]-[two(three)]-[three(four)]-[four(five)]-[five]-|" options:0 metrics:metrics views:views];
        
        NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[one(160)]-|" options:0 metrics:metrics views:views];
        NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[two(160)]-|" options:0 metrics:metrics views:views];
        NSArray *constraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[three(160)]-|" options:0 metrics:metrics views:views];
        NSArray *constraints5 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[four(160)]-|" options:0 metrics:metrics views:views];
        NSArray *constraints6 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[five(160)]-|" options:0 metrics:metrics views:views];
        
        [self addConstraints:constraints1];
        [self addConstraints:constraints2];
        [self addConstraints:constraints3];
        [self addConstraints:constraints4];
        [self addConstraints:constraints5];
        [self addConstraints:constraints6];
        
    }
    return self;
}

+ (instancetype)viewWithArr:(NSArray *)KBArr {
    return [[self alloc] initWithArr:KBArr];
}

@end
