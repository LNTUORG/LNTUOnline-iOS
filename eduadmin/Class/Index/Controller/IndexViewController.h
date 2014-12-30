//
//  IndexViewController.h
//  eduadmin
//
//  Created by JieLee on 14/12/30.
//  Copyright (c) 2014年 JieLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *helloLable;

@property (nonatomic, strong) NSDictionary *dict;

- (IBAction)logout:(id)sender;

- (IBAction)myInfo;

- (IBAction)mySchedule;

- (IBAction)announce;

- (IBAction)unpassGrade;

- (IBAction)queryGrade;

- (IBAction)examPlan;

- (IBAction)skillTest;

@end
