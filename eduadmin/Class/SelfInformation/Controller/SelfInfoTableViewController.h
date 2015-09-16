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

@property (strong, nonatomic) NSArray *titles;

@property (strong, nonatomic) NSArray *basicInfoKey;

@property (strong, nonatomic) NSArray *basicInfoValue;

@property (strong, nonatomic) NSArray *disActKey;

@property (strong, nonatomic) SelfInformation *information;

@property (weak, nonatomic) IBOutlet UIImageView *personalImg;

@end
