//
//  IndexViewController.h
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexViewController : UIViewController

@property (nonatomic, copy) NSDictionary *dict;

@property (nonatomic, strong) NSUserDefaults *def;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UILabel *nameLable;

@property (strong, nonatomic) IBOutlet UILabel *helloLable;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *escButton;

- (IBAction)logout:(id)sender;

- (IBAction)myInfo;

- (IBAction)mySchedule;

- (IBAction)announce;

- (IBAction)unpassGrade;

- (IBAction)queryGrade;

- (IBAction)examPlan;

- (IBAction)skillTest;

- (IBAction)donate;

- (IBAction)oneKeyRate;

- (IBAction)fresher;

@end
