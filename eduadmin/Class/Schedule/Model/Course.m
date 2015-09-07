//
//  Course.m
//  eduadmin
//
//  Created by JieLee on 15/6/6.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "Course.h"
#import "MJExtension.h"
#import "TimeAndPlace.h"

@implementation Course

- (NSDictionary *)objectClassInArray {
    
    return @{@"timesAndPlaces": [TimeAndPlace class]};
}

@end
