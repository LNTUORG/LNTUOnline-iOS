//
//  JWGradeViewController.h
//  lntuApp
//
//  Created by Li Jie on 14/10/1.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradeViewController : UIViewController

@property (nonatomic, copy) NSArray *allGradeArr;
@property (nonatomic, strong) NSMutableArray *currentGradeArr;
@property (nonatomic, copy) NSArray *yearArr;
@property (nonatomic, copy) NSArray *termArr;

@property (nonatomic, assign) NSInteger yearIndex;
@property (nonatomic, assign) NSInteger termIndex;

@property (nonatomic, copy) NSString *averageCredit;

@property (strong, nonatomic) IBOutlet UIPickerView *pickView;

@property (strong, nonatomic) IBOutlet UIControl *pickerDevice;

@property (strong, nonatomic) IBOutlet UILabel *yearLable;

@property (strong, nonatomic) IBOutlet UILabel *termLable;

@property (strong, nonatomic) IBOutlet UITableView *gradeView;

- (IBAction)endEditing;

@end
