//
//  SelfInfoTableViewController.h
//  eduadmin
//
//  Created by Li Jie on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelfInformation;

@interface SelfInfoTableViewController : UITableViewController

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, copy) NSArray *basicInfoKey;

@property (nonatomic, copy) NSArray *basicInfoValue;

@property (nonatomic, copy) NSArray *disActKey;

@property (nonatomic, strong) SelfInformation *information;

@property (strong, nonatomic) IBOutlet UIImageView *personalImg;

@end
