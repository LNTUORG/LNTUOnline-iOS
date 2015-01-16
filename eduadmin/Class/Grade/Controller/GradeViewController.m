//
//  JWGradeViewController.m
//  lntuApp
//
//  Created by 李杰 on 14/10/1.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "GradeViewController.h"
#import "DetailGradeController.h"
#import "Common.h"
#import "LJTools.h"
#import "MBProgressHUD+LJ.h"
#import "MyGrade.h"
#import "MJExtension.h"
#import "PartGradeCell.h"
#import "RatingInfo.h"

@interface GradeViewController () <UIAlertViewDelegate,UIPickerViewDelegate>
{
    NSArray *_gradeArr;
    NSArray *_yearArr;
    NSArray *_termArr;
    NSMutableArray *_rateArr;
    NSString *_year;
    NSString *_term;
}
@end

@implementation GradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gradeView.tableFooterView = [[UIView alloc] init];
    
    NSInteger year = [LJTimeTool getCurrentYear];
    
    if ([LJTimeTool getCurrentMonth]<=3) {
        year--;
    }
    
    _yearArr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", (int)year],[NSString stringWithFormat:@"%d", (int)year-1],[NSString stringWithFormat:@"%d", (int)year-2],[NSString stringWithFormat:@"%d", (int)year-3],[NSString stringWithFormat:@"%d", (int)year-4],[NSString stringWithFormat:@"%d", (int)year-5], nil];
    _termArr = [NSArray arrayWithObjects:@"1",@"2",nil];
    _rateArr = [NSMutableArray array];
    _year = _yearArr[0];
    
    if ([LJTimeTool getCurrentMonth]>=5 && [LJTimeTool getCurrentMonth]<11) {
        _term = _termArr[0];
    }else{_term = _termArr[1];}
    
    
    
    self.yearLable.text = [NSString stringWithFormat:@"%@年",_year];
    if ([_term intValue]==1) {
        self.termLable.text = @"春";
    }else{self.termLable.text = @"秋";}
    
    [self getGrade:[NSString stringWithFormat:@"%@grades/courseScoresInfo?year=%@&term=%@",sinaURL,_year,_term]];
    
}

- (void)getGrade:(NSString *)url
{
    [MBProgressHUD showMessage:waitStr];
    [LJHTTPTool getJSONWithURL:url params:nil success:^(id responseJSON) {
        _gradeArr = [MyGrade objectArrayWithKeyValuesArray:responseJSON];
        [self.gradeView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];

        [MBProgressHUD showError:nullStr];
    }];
}

#pragma mark pickerView 代理方法 and 数据源

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _yearArr.count;
    }else
    {
        return _termArr.count;}
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        NSString *str = [NSString stringWithFormat:@"%@年",_yearArr[row]];
        return str;
    }else{
        NSString *str = [NSString stringWithFormat:@"第%@学期",_termArr[row]];
        return str;
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        _year = _yearArr[row];
        [self getGrade:[NSString stringWithFormat:@"%@grades/courseScoresInfo?year=%@&term=%@",sinaURL,_year,_term]];
        self.yearLable.text = [NSString stringWithFormat:@"%@年",_year];
    }else{
        _term = _termArr[row];
        [self getGrade:[NSString stringWithFormat:@"%@grades/courseScoresInfo?year=%@&term=%@",sinaURL,_year,_term]];
        if ([_term intValue]==1) {
            self.termLable.text = @"春";
        }else{self.termLable.text = @"秋";}
    }
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _gradeArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PartGradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"part"];
    
    if (cell == nil) {
        cell = [PartGradeCell newPartGradeCell];
    }
    
    cell.grade = _gradeArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[_gradeArr[indexPath.row],@"0"];
    
    [self performSegueWithIdentifier:@"grade2detail" sender:arr];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailGradeController *con = segue.destinationViewController;
    con.arr = sender;
}


- (IBAction)endEditing {
    
    CGRect pickerR = self.pickerDevice.frame;
    
    if (pickerR.origin.y >0) {
        pickerR.origin.y -= 165;
    }else{
        pickerR.origin.y += 165;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    self.pickerDevice.frame = pickerR;
    [UIView commitAnimations];
    
}

- (IBAction)rating:(id)sender {
    [MBProgressHUD showMessage:waitStr];
    
    [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@oneKey/info",sinaURL] params:nil success:^(id responseJSON) {
        
        NSArray *allArr = [RatingInfo objectArrayWithKeyValuesArray:responseJSON];
        
        for (RatingInfo *info in allArr) {
            if (info.url) {
                [_rateArr addObject:info];
            }
        }
        
        if (_rateArr.count) {
            [self didRating];
        }else {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"已经评课或当前无法评课"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"给个好评吧" message:@"给过老师好评，是不是心情棒棒哒，也给我们个好评吧" delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"好哒", nil];
                [alert show];
                
            });
        }
        
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"已经评课或当前无法评课"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"给个好评吧" message:@"给过老师好评，是不是心情棒棒哒，也给我们个好评吧" delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"好哒", nil];
            [alert show];
            
        });
    }];
    
}

- (void)didRating {

    [MBProgressHUD hideHUD];
    
    for (RatingInfo *info in _rateArr) {
        NSDictionary *param = @{@"url": info.url};
        
        [LJHTTPTool postHTTPWithURL:[NSString stringWithFormat:@"%@oneKey/evaluateOne",sinaURL] params:param success:^(id responseHTTP) {
            
            NSString *flag = [[NSString alloc] initWithData:responseHTTP encoding:NSUTF8StringEncoding];
            if ([flag isEqualToString:@"OK"]){
                
                [MBProgressHUD showSuccess:@"成功+1"];
            }
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:errorStr];
        }];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"给个好评吧" message:@"给过老师好评，是不是心情棒棒哒，也给我们个好评吧" delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"好哒", nil];
        [alert show];
        
    });
    
    
}

#pragma mark alert代理
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *url = storeURL;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

- (void)movePicker:(NSInteger)y
{
    CGRect pickerR = self.pickerDevice.frame;
    pickerR.origin.y = y;
    self.pickerDevice.frame = pickerR;
}

@end
