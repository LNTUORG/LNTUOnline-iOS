//
//  ScheduleViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/31.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "ScheduleViewController.h"
#import "MBProgressHUD+LJ.h"
#import "LJTools.h"
#import "Common.h"
#import "MJRefresh.h"
#import "KBView.h"
#import "UIView+Autolayout.h"

@interface ScheduleViewController ()

//@property (nonatomic, strong) MSTabScrollView *tabScrollView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *timeArr;
@end

@implementation ScheduleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = [NSString stringWithFormat:@"第%d周", [LJTimeTool getCurrentWeek] - 10];
    
    
//    [self createPageScrollView];
    
    self.timeArr = @[@"第 0 节 08:00-08:45\n第 1 节 08:50-09:35", @"第 2 节 09:55-10:40\n第 3 节 10:45-11:30", @"第 4 节 13:30-14:15\n第 5 节 14:20-15:05", @"第 6 节 15:25-16:10\n第 7 节 16:15-17:00", @"第 8 节 18:30-19:15\n第 9 节 19:20-20:05"];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
//    [self.tabScrollView resetPageViewContentSize];
}







- (NSString *)getAddress:(NSString *)fileName {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [def objectForKey:userNameKey];
    
    if (str.length) {
        return [NSString stringWithFormat:@"%@%@",str,fileName];
    } else {
        return @"error";
    }
}

- (void)refreshData
{
    
    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@curriculum/info",sinaURL] params:nil success:^(id responseJSON) {
        
        [LJFileTool writeToFileContent:responseJSON withFileName:[self getAddress:scheduleFileName]];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:nullStr];
    }];
}


- (IBAction)reloadCourse:(id)sender {
    
    [self refreshData];
}
@end
