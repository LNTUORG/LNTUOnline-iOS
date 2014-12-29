//
//  LJTimeTool.m
//
//  Created by 李杰 on 14/9/22.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "LJTimeTool.h"

@implementation LJTimeTool

+ (NSInteger)getCurrentYear
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =
    NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    return [dateComponent year];
}


+ (NSString *)getCurrentInterval
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =
    NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    long hour = [dateComponent hour];
    if (hour>=0&&hour<4) {
        return @"凌晨";
    }else if (hour>=4&&hour<9){
        return @"早上";
    }else if (hour>=9&&hour<11){
        return @"上午";
    }else if (hour>=11&&hour<14){
        return @"中午";
    }else if (hour>=14&&hour<19){
        return @"下午";
    }else if (hour>=19&&hour<24){
        return @"晚上";
    }
    else return @"error";
}

+ (int)dayNumberSinceDateWithFormat_yyyy_MM_dd:(NSString *)date
{
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    
    [dm setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * newdate = [dm dateFromString:date];
    
    NSTimeInterval reTime = [newdate timeIntervalSinceNow];
    
    int lastDay = (int)reTime/3600/24;
    return lastDay;
}

@end
