//
//  UIView+Autolayout.m
//  PageScroll-Demo
//
//  Created by JieLee on 15/3/27.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "UIView+Autolayout.h"

@implementation UIView (Autolayout)
+(instancetype)autolayoutView
{
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}
@end
