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
#import "iCarousel.h"
#import "DayClassTableViewCell.h"
#import "NightClassTableViewCell.h"
#import "DayCourse.h"

@interface ScheduleViewController () <iCarouselDataSource, iCarouselDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet iCarousel *iCaView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *courseArray;
@end

@implementation ScheduleViewController

- (void)dealloc
{
    self.iCaView.delegate = nil;
    self.iCaView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.iCaView.type = iCarouselTypeRotary;
    self.iCaView.pagingEnabled = YES;
    
    self.iCaView.currentItemIndex = [LJTimeTool getCurrentWeekDay] - 1;
    
    self.navigationItem.title = [NSString stringWithFormat:@"第%d周", [LJTimeTool getCurrentWeek] - 10];
    
    self.titleArray = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.iCaView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark iCarousel methods


- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 7;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    NSInteger HEIGHT = [UIScreen mainScreen].bounds.size.height - 40 - 64;
    NSInteger WIDTH = [UIScreen mainScreen].bounds.size.width - 30;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    
    tableView.tag = index;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.allowsSelection = NO;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.alwaysBounceVertical = NO;
    tableView.backgroundColor = [UIColor colorWithRed:214/255.0 green:227/255.0 blue:181/255.0 alpha:1];

    NSString *filePath = [LJFileTool getFilePath:[self getAddress:scheduleFileName]];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        self.courseArray = [self getCourseArray:dict];
    }else{
        [self refreshData];
    }

    return tableView;
}

#pragma mark Table methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"head"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"head"];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = self.titleArray[tableView.tag];
        return cell;
    }
    if (indexPath.row == 1) {
        
        DayClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"day"];
        if (!cell) {
            cell = [DayClassTableViewCell newDayClassCell];
        }
        
        cell.course0 = self.courseArray[tableView.tag][0];
        cell.course1 = self.courseArray[tableView.tag][1];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_morning"]];
        return  cell;
    }
    if (indexPath.row == 2) {
        
        DayClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"day"];
        if (!cell) {
            cell = [DayClassTableViewCell newDayClassCell];
        }
        
        DayCourse *course = [DayCourse new];
        course.class0 = self.courseArray[tableView.tag][2];
        course.class1 = self.courseArray[tableView.tag][3];
        
        cell.course = course;
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_afternoon"]];
        return  cell;
    }
    else {
    
        NightClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"night"];
        if (!cell) {
            cell = [NightClassTableViewCell newNightClassCell];
        }
        
        cell.course = self.courseArray[tableView.tag][4];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_night"]];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 44;
    }
    if (indexPath.row == 3) {
        return 106;
    }
    else {
        
        return 212;
    }
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
    
//    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@curriculum/info",sinaURL] params:nil success:^(id responseJSON) {
//        
//        [LJFileTool writeToFileContent:responseJSON withFileName:[self getAddress:scheduleFileName]];
//        
//        [self.iCaView reloadData];
//    } failure:^(NSError *error) {
//        
//        [MBProgressHUD showError:nullStr];
//    }];
}

- (IBAction)reloadCourse:(id)sender {
    
    [self refreshData];
}
@end
