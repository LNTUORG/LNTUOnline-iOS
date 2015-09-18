//
//  JWUnpassGrade.m
//  lntuApp
//
//  Created by Li Jie on 14/9/28.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "UnpassGrade.h"
#import "MJExtension.h"
#import "UnpassGradeRecord.h"

@implementation UnpassGrade

- (NSDictionary *)objectClassInArray {
    
    return @{@"records": [UnpassGradeRecord class]};
}

@end
