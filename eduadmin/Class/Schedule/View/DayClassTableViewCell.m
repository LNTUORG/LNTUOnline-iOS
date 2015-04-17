//
//  DayClassTableViewCell.m
//  eduadmin
//
//  Created by JieLee on 4/18/15.
//  Copyright (c) 2015 PUPBOSS. All rights reserved.
//

#import "DayClassTableViewCell.h"

@implementation DayClassTableViewCell

+ (id)newDayClassCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"DayClassTableViewCell" owner:nil options:nil][0];
}

@end
