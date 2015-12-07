//
//  Title.h
//  eduadmin
//
//  Created by Li Jie on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Title : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign, getter=isOpen) BOOL open;

- (instancetype)initWithString:(NSString *)str;

+ (instancetype)titleWithString:(NSString *)str;

@end
