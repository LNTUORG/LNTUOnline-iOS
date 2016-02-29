//
//  HeaterTempCell.m
//  eduadmin
//
//  Created by Li Jie on 15/5/29.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "HeaterTempCell.h"

@implementation HeaterTempCell

- (void)setInfo:(NSArray *)info {
    
    _info = info;
    
    self.locateLabel.text = info[1];
    self.timeLabel.text = [NSString stringWithFormat:@"最近更新于:%@", info[4]];
    self.tempLabel.text = [NSString stringWithFormat:@"%@°C", info[2]];
    self.countLabel.text = [NSString stringWithFormat:@"大约%@人在排队(仅供参考)", info[3]];
}
@end
