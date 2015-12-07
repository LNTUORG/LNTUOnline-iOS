//
//  Course.h
//  eduadmin
//
//  Created by Li Jie on 15/6/6.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, strong) NSArray *timesAndPlaces;

@end
