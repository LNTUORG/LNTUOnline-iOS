//
//  TimeAndPlace.h
//  eduadmin
//
//  Created by JieLee on 15/6/6.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeAndPlace : NSObject


@property (nonatomic, copy) NSString *dayInWeek;
@property (nonatomic, assign) NSInteger endWeek;
@property (nonatomic, copy) NSString *room;
@property (nonatomic, copy) NSString *stage;
@property (nonatomic, assign) NSInteger startWeek;
@property (nonatomic, copy) NSString *weekMode;

@end
