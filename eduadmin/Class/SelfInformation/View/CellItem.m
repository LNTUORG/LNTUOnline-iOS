//
//  CellItem.m
//  教务处
//
//  Created by Li Jie on 14-8-10.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "CellItem.h"

@implementation CellItem

+ (id)newCellItem
{
    return [[NSBundle mainBundle] loadNibNamed:@"CellItem" owner:nil options:nil][0];
}

- (void)setTName:(NSString *)tName
{
    _tName = tName;
    self.name.text = tName;
}

- (void)setTValue:(NSString *)tValue
{
    _tValue = tValue;
    self.value.text = tValue;
}

@end
