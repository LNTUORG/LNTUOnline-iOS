//
//  Title.m
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "Title.h"

@implementation Title

- (instancetype)initWithString:(NSString *)str
{
    if (self = [super init]) {
        self.name = str;
    }
    return self;
}

+ (instancetype)titleWithString:(NSString *)str
{
    return [[self alloc] initWithString:str];
}

@end
