//
//  LJTimeTool.h
//
//  Created by 李杰 on 14/9/22.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJTimeTool : NSObject

+ (NSInteger)getCurrentWeek;

+ (NSInteger)getCurrentWeekDay;

+ (NSInteger)getCurrentYear;

+ (NSInteger)getCurrentMonth;

+ (NSString *)getCurrentInterval;

+ (NSInteger)getCurrentClass;

+ (NSInteger)dayNumberSinceDateWithFormat_yyyy_MM_dd_HH_mm:(NSString *)date;

+ (NSInteger)getWeekOfDateWithFormat_yyyy_MM_dd:(NSString *)date;
@end
