//
//  JWGradeViewController.h
//  lntuApp
//
//  Created by 李杰 on 14/10/1.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIControl *pickerDevice;

@property (weak, nonatomic) IBOutlet UILabel *yearLable;

@property (weak, nonatomic) IBOutlet UILabel *termLable;

@property (weak, nonatomic) IBOutlet UITableView *gradeView;

- (IBAction)endEditing;

- (IBAction)rating:(id)sender;


@end
