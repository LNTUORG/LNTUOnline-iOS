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

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (void)viewDidLayoutSubviews
{
    //内容尺寸
    self.schScrollView.contentSize = CGSizeMake(444,672);
    
    //隐藏滚动条
    self.schScrollView.showsHorizontalScrollIndicator = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *filePath = [LJFileTool getFilePath:[self getAddress:scheduleFileName]];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        [self showCourses:dict];
        
    }else{
        [self refreshData];
    }
    
    //内容尺寸
    self.schScrollView.contentSize = CGSizeMake(444,672);
    
    //隐藏滚动条
    self.schScrollView.showsHorizontalScrollIndicator = YES;
}

- (NSString *)getAddress:(NSString *)fileName {
    
    NSString *filePath = [LJFileTool getFilePath:loginFileName];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        return [NSString stringWithFormat:@"%@%@",dict[@"userName"],fileName];
    }else {
        return @"error";
    }
    
}

- (void)refreshData
{
    [MBProgressHUD showMessage:waitStr];
    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@curriculum/info",sinaURL] params:nil success:^(id responseJSON) {
        
        [LJFileTool writeToFileContent:responseJSON withFileName:[self getAddress:scheduleFileName]];
        [self showCourses:responseJSON];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:nullStr];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


- (void)showCourses:(NSDictionary *)responseObject
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
    
    NSDictionary *courses = dict[@"courses"];
    
    if ([courses[@"1-1"] isEqualToString:@""]) {
        self.s1_1.backgroundColor = [UIColor whiteColor];
    }else{
        self.s1_1.text = courses[@"1-1"];
    }
    if ([courses[@"1-2"] isEqualToString:@""]) {
        self.s1_2.backgroundColor = [UIColor whiteColor];
    }else{
        self.s1_2.text = courses[@"1-2"];
    }
    if ([courses[@"1-3"] isEqualToString:@""]) {
        self.s1_3.backgroundColor = [UIColor whiteColor];
    }else{
        self.s1_3.text = courses[@"1-3"];
    }
    if ([courses[@"1-4"] isEqualToString:@""]) {
        self.s1_4.backgroundColor = [UIColor whiteColor];
    }else{
        self.s1_4.text = courses[@"1-4"];
    }
    if ([courses[@"1-5"] isEqualToString:@""]) {
        self.s1_5.backgroundColor = [UIColor whiteColor];
    }else{
        self.s1_5.text = courses[@"1-5"];
    }
    
    
    if ([courses[@"2-1"] isEqualToString:@""]) {
        self.s2_1.backgroundColor = [UIColor whiteColor];
    }else{
        self.s2_1.text = courses[@"2-1"];
    }
    if ([courses[@"2-2"] isEqualToString:@""]) {
        self.s2_2.backgroundColor = [UIColor whiteColor];
    }else{
        self.s2_2.text = courses[@"2-2"];
    }
    if ([courses[@"2-3"] isEqualToString:@""]) {
        self.s2_3.backgroundColor = [UIColor whiteColor];
    }else{
        self.s2_3.text = courses[@"2-3"];
    }
    if ([courses[@"2-4"] isEqualToString:@""]) {
        self.s2_4.backgroundColor = [UIColor whiteColor];
    }else{
        self.s2_4.text = courses[@"2-4"];
    }
    if ([courses[@"2-5"] isEqualToString:@""]) {
        self.s2_5.backgroundColor = [UIColor whiteColor];
    }else{
        self.s2_5.text = courses[@"2-5"];
    }
    
    
    if ([courses[@"3-1"] isEqualToString:@""]) {
        self.s3_1.backgroundColor = [UIColor whiteColor];
    }else{
        self.s3_1.text = courses[@"3-1"];
    }
    if ([courses[@"3-2"] isEqualToString:@""]) {
        self.s3_2.backgroundColor = [UIColor whiteColor];
    }else{
        self.s3_2.text = courses[@"3-2"];
    }
    if ([courses[@"3-3"] isEqualToString:@""]) {
        self.s3_3.backgroundColor = [UIColor whiteColor];
    }else{
        self.s3_3.text = courses[@"3-3"];
    }
    if ([courses[@"3-4"] isEqualToString:@""]) {
        self.s3_4.backgroundColor = [UIColor whiteColor];
    }else{
        self.s3_4.text = courses[@"3-4"];
    }
    if ([courses[@"3-5"] isEqualToString:@""]) {
        self.s3_5.backgroundColor = [UIColor whiteColor];
    }else{
        self.s3_5.text = courses[@"3-5"];
    }
    
    if ([courses[@"4-1"] isEqualToString:@""]) {
        self.s4_1.backgroundColor = [UIColor whiteColor];
    }else{
        self.s4_1.text = courses[@"4-1"];
    }
    if ([courses[@"4-2"] isEqualToString:@""]) {
        self.s4_2.backgroundColor = [UIColor whiteColor];
    }else{
        self.s4_2.text = courses[@"4-2"];
    }
    if ([courses[@"4-3"] isEqualToString:@""]) {
        self.s4_3.backgroundColor = [UIColor whiteColor];
    }else{
        self.s4_3.text = courses[@"4-3"];
    }
    if ([courses[@"4-4"] isEqualToString:@""]) {
        self.s4_4.backgroundColor = [UIColor whiteColor];
    }else{
        self.s4_4.text = courses[@"4-4"];
    }
    if ([courses[@"4-5"] isEqualToString:@""]) {
        self.s4_5.backgroundColor = [UIColor whiteColor];
    }else{
        self.s4_5.text = courses[@"4-5"];
    }
    
    if ([courses[@"5-1"] isEqualToString:@""]) {
        self.s5_1.backgroundColor = [UIColor whiteColor];
    }else{
        self.s5_1.text = courses[@"5-1"];
    }
    if ([courses[@"5-2"] isEqualToString:@""]) {
        self.s5_2.backgroundColor = [UIColor whiteColor];
    }else{
        self.s5_2.text = courses[@"5-2"];
    }
    if ([courses[@"5-3"] isEqualToString:@""]) {
        self.s5_3.backgroundColor = [UIColor whiteColor];
    }else{
        self.s5_3.text = courses[@"5-3"];
    }
    if ([courses[@"5-4"] isEqualToString:@""]) {
        self.s5_4.backgroundColor = [UIColor whiteColor];
    }else{
        self.s5_4.text = courses[@"5-4"];
    }
    if ([courses[@"5-5"] isEqualToString:@""]) {
        self.s5_5.backgroundColor = [UIColor whiteColor];
    }else{
        self.s5_5.text = courses[@"5-5"];
    }
    
    if ([courses[@"6-1"] isEqualToString:@""]) {
        self.s6_1.backgroundColor = [UIColor whiteColor];
    }else{
        self.s6_1.text = courses[@"6-1"];
    }
    if ([courses[@"6-2"] isEqualToString:@""]) {
        self.s6_2.backgroundColor = [UIColor whiteColor];
    }else{
        self.s6_2.text = courses[@"6-2"];
    }
    if ([courses[@"6-3"] isEqualToString:@""]) {
        self.s6_3.backgroundColor = [UIColor whiteColor];
    }else{
        self.s6_3.text = courses[@"6-3"];
    }
    if ([courses[@"6-4"] isEqualToString:@""]) {
        self.s6_4.backgroundColor = [UIColor whiteColor];
    }else{
        self.s6_4.text = courses[@"6-4"];
    }
    if ([courses[@"6-5"] isEqualToString:@""]) {
        self.s6_5.backgroundColor = [UIColor whiteColor];
    }else{
        self.s6_5.text = courses[@"6-5"];
    }
    
    if ([courses[@"7-1"] isEqualToString:@""]) {
        self.s7_1.backgroundColor = [UIColor whiteColor];
    }else{
        self.s7_1.text = courses[@"7-1"];
    }
    if ([courses[@"7-2"] isEqualToString:@""]) {
        self.s7_2.backgroundColor = [UIColor whiteColor];
    }else{
        self.s7_2.text = courses[@"7-2"];
    }
    if ([courses[@"7-3"] isEqualToString:@""]) {
        self.s7_3.backgroundColor = [UIColor whiteColor];
    }else{
        self.s7_3.text = courses[@"7-3"];
    }
    if ([courses[@"7-4"] isEqualToString:@""]) {
        self.s7_4.backgroundColor = [UIColor whiteColor];
    }else{
        self.s7_4.text = courses[@"7-4"];
    }
    if ([courses[@"7-5"] isEqualToString:@""]) {
        self.s7_5.backgroundColor = [UIColor whiteColor];
    }else{
        self.s7_5.text = courses[@"7-5"];
    }
}

- (IBAction)refresh:(id)sender {
    [self refreshData];
}

@end
