//
//  KBView.h
//  PageScroll-Demo
//
//  Created by JieLee on 15/3/27.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBView : UIView

@property (nonatomic, copy) NSString *date;

- (instancetype)initWithArr:(NSArray *)KBArr;
+ (instancetype)viewWithArr:(NSArray *)KBArr;

@end
