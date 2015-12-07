//
//  JWGradeViewController.h
//  lntuApp
//
//  Created by Li Jie on 14/10/1.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradeViewController : UIViewController

@property (strong, nonatomic) NSArray *allGradeArr;
@property (strong, nonatomic) NSMutableArray *currentGradeArr;
@property (strong, nonatomic) NSArray *yearArr;
@property (strong, nonatomic) NSArray *termArr;

@property (assign, nonatomic) NSInteger yearIndex;
@property (assign, nonatomic) NSInteger termIndex;

@property (copy, nonatomic) NSString *averageCredit;

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@property (weak, nonatomic) IBOutlet UIControl *pickerDevice;

@property (weak, nonatomic) IBOutlet UILabel *yearLable;

@property (weak, nonatomic) IBOutlet UILabel *termLable;

@property (weak, nonatomic) IBOutlet UITableView *gradeView;

- (IBAction)endEditing;

@end
