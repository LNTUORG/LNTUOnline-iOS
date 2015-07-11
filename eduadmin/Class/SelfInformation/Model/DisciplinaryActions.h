//
//  DisciplinaryActions.h
//  eduadmin
//
//  Created by JieLee on 4/19/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisciplinaryActions : NSObject

@property (nonatomic, copy) NSString *cancelReason;

@property (nonatomic, copy) NSString *createReason;

@property (nonatomic, strong) NSDate *createTime;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, copy) NSString *state;

@end
