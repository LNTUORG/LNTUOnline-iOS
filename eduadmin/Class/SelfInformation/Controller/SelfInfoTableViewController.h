//
//  SelfInfoTableViewController.h
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelfInformation;

@interface SelfInfoTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *basicInfoKey;

@property (strong, nonatomic) NSArray *titles;

@property (strong, nonatomic) NSArray *basicInfoValue;

@property (strong, nonatomic) SelfInformation *imformation;

@property (weak, nonatomic) IBOutlet UIImageView *personalImg;

@end
