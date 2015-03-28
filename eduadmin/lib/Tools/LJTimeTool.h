//
//  LJTimeTool.h
//
//  Created by 李杰 on 14/9/22.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJTimeTool : NSObject

+ (NSInteger)getCurrentWeekDay;

+ (NSInteger)getCurrentYear;

+ (NSInteger)getCurrentMonth;

+ (NSString *)getCurrentInterval;

+ (int)dayNumberSinceDateWithFormat_yyyy_MM_dd:(NSString *)date;

@end
