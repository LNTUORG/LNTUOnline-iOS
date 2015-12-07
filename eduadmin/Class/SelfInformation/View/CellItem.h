//
//  CellItem.h
//  教务处
//
//  Created by Li Jie on 14-8-10.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellItem : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *name;

@property (nonatomic, weak) IBOutlet UILabel *value;

@property (nonatomic, copy) NSString *tName;
@property (nonatomic, copy) NSString *tValue;

+ (instancetype)newCellItem;

@end
