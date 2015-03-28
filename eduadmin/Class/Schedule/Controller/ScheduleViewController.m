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

@property (nonatomic, strong) MSTabScrollView *tabScrollView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *timeArr;
@end

@implementation ScheduleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = [NSString stringWithFormat:@"第%ld周", [LJTimeTool getCurrentWeek] - 10];
    
    [self createPageScrollView];
    
    self.timeArr = @[@"第 0 节 08:00-08:45\n第 1 节 08:50-09:35", @"第 2 节 09:55-10:40\n第 3 节 10:45-11:30", @"第 4 节 13:30-14:15\n第 5 节 14:20-15:05", @"第 6 节 15:25-16:10\n第 7 节 16:15-17:00", @"第 8 节 18:30-19:15\n第 9 节 19:20-20:05"];
    
    [self createClassTime];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.tabScrollView resetPageViewContentSize];
}


- (void)createClassTime {

    UILabel *one = [UILabel autolayoutView];
    
    UILabel *two = [UILabel autolayoutView];
    
    UILabel *three = [UILabel autolayoutView];
    
    UILabel *four = [UILabel autolayoutView];
    
    UILabel *five = [UILabel autolayoutView];
    
    NSInteger labelNumber = 0;
    for (UILabel *lable in @[one, two, three, four, five]) {
        
        lable.textColor = [UIColor darkGrayColor];
        lable.text = self.timeArr[labelNumber++];
        lable.font = [UIFont systemFontOfSize:17];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.numberOfLines = 0;
        [self.backImg addSubview:lable];
    }
    
    five.textColor = [UIColor whiteColor];
    
    NSInteger screenWidth = [[UIScreen mainScreen] bounds].size.width / 2;
    
    NSDictionary *metrics = @{@"height":@(screenWidth)};
    NSDictionary *views = NSDictionaryOfVariableBindings(one, two, three, four, five);
    
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[one(two)]-[two(three)]-[three(four)]-[four(five)]-[five]-|" options:0 metrics:metrics views:views];
    
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[one(height)]" options:0 metrics:metrics views:views];
    NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[two(height)]" options:0 metrics:metrics views:views];
    NSArray *constraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[three(height)]" options:0 metrics:metrics views:views];
    NSArray *constraints5 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[four(height)]" options:0 metrics:metrics views:views];
    NSArray *constraints6 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[five(height)]" options:0 metrics:metrics views:views];
    
    [self.backImg addConstraints:constraints1];
    [self.backImg addConstraints:constraints2];
    [self.backImg addConstraints:constraints3];
    [self.backImg addConstraints:constraints4];
    [self.backImg addConstraints:constraints5];
    [self.backImg addConstraints:constraints6];
}


- (void)createPageScrollView {
    self.titleArray = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat pageHeight = KDevice_Height - kStatusBarHeight;
    CGFloat pageWidth = KDevice_Width;
    self.tabScrollView = [[MSTabScrollView alloc]initWithPageWidth:pageWidth  PageHeight:pageHeight Delegate:self];
    self.tabScrollView.tabSelectedColor = [UIColor colorWithRed:0/255.0 green:160/255.0 blue:233/255.0 alpha:1]; //默认颜色，可不设置
    self.tabScrollView.tabBackgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]; //默认颜色，可不设置
    self.tabScrollView.selectedTabIndex = [LJTimeTool getCurrentWeekDay] - 1; //默认位置，可不设置
    
    [self.tabScrollView handleLayout];
    [self.view addSubview:self.tabScrollView];
    
    
    //使用自动布局，非自动布局时去掉
    NSDictionary *metrics = @{@"TopHeight":@(kStatusBarHeight)};
    [self.tabScrollView setCustomLayoutWithVisualFormat1:@"H:|[view]|"
                                                 Format2:@"V:|-TopHeight-[view]-|"
                                                 metrics:metrics
                                               superView:self.view];
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
        
        [self.tabScrollView reloadInputViews];
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:nullStr];
    }];
}

#pragma mark - MSTabScrollViewDelegate
- (NSInteger)NumberOfTabInTabScrollView:(UIScrollView *)tabScrollView {
    return self.titleArray.count;
}

- (UIView *)tabScrollView:(UIScrollView *)tabScrollView pageViewForTabIndex:(NSInteger)tabIndex {
    
    KBView *pageView = [[KBView alloc] init];
    
    NSString *filePath = [LJFileTool getFilePath:[self getAddress:scheduleFileName]];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    NSArray *courseArr = [NSArray array];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        courseArr = [self getCourseArray:dict];
        
        pageView = [KBView viewWithArr:courseArr[tabIndex]];
        
    }else{
        [self refreshData];
    }
    
    return pageView;
}

- (NSArray *)getCourseArray:(NSDictionary *)dict {
    
    NSDictionary *courses = dict[@"courses"];
    
    NSArray *arr0 = @[courses[@"7-1"], courses[@"7-2"], courses[@"7-3"], courses[@"7-4"], courses[@"7-5"]];
    NSArray *arr1 = @[courses[@"1-1"], courses[@"1-2"], courses[@"1-3"], courses[@"1-4"], courses[@"1-5"]];
    NSArray *arr2 = @[courses[@"2-1"], courses[@"2-2"], courses[@"2-3"], courses[@"2-4"], courses[@"2-5"]];
    NSArray *arr3 = @[courses[@"3-1"], courses[@"3-2"], courses[@"3-3"], courses[@"3-4"], courses[@"3-5"]];
    NSArray *arr4 = @[courses[@"4-1"], courses[@"4-2"], courses[@"4-3"], courses[@"4-4"], courses[@"4-5"]];
    NSArray *arr5 = @[courses[@"5-1"], courses[@"5-2"], courses[@"5-3"], courses[@"5-4"], courses[@"5-5"]];
    NSArray *arr6 = @[courses[@"6-1"], courses[@"6-2"], courses[@"6-3"], courses[@"6-4"], courses[@"6-5"]];
    
    NSArray *array = @[arr0, arr1, arr2, arr3, arr4, arr5, arr6];
    return array;
}

- (NSString *)tabScrollView:(UIScrollView *)tabScrollView titleForTabIndex:(NSInteger)tabIndex {
    if (tabIndex < self.titleArray.count) {
        return self.titleArray[tabIndex];
    }
    return nil;
}

//适应设备旋转时增加以下部分代码
#pragma mark - UIViewControllerRotation
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations

{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            [self.tabScrollView updatePageViewConstraint:InterfaceOrientationPortrait];
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            [self.tabScrollView updatePageViewConstraint:InterfaceOrientationLandscape];
        default:
            break;
    }
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
}

- (IBAction)reloadCourse:(id)sender {
    
    [self refreshData];
}
@end
