//
//  IndexViewController.h
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *helloLable;

@property (nonatomic, strong) NSDictionary *dict;

@property (strong, nonatomic) NSUserDefaults *def;

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
