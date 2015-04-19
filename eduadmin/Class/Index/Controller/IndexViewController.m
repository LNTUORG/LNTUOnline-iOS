//
//  IndexViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "IndexViewController.h"
#import "MBProgressHUD+LJ.h"
#import "AFNetworking.h"
#import "LJTools.h"
#import "Common.h"

@interface IndexViewController () <UIActionSheetDelegate,UIAlertViewDelegate>
{
    NSArray *_helloArr;
}
@end

@implementation IndexViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.alwaysBounceVertical = YES;
    self.helloLable.numberOfLines = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    if (![def objectForKey:LOGINTOKEN]) {
        [self performSegueWithIdentifier:@"index2login" sender:nil];
    }
    
    _helloArr = @[@"爱生活不爱黑眼圈,快洗洗睡吧",@"一日之计在于晨,上课可别打瞌睡哦",@"坐等下课吃饭去",@"吃个饱饭睡个美容觉,这真是极好的",@"中午养足了精神吗?让我们一起渡过一个愉快的下午茶时间,不过没有茶喝o(╯□╰)o",@"静能生慧.仰观宇宙之大,俯察品类之盛.宇宙之大,每个生命都在孤寂"];
    [self isNewest];
    
    [self getPhotoAndName];
    [self setHelloLableText];
    
#pragma mark 推送相关
    
    if ([def objectForKey:pushTokenNew]) {
        if (![[def objectForKey:pushTokenOld] isEqualToString:[def objectForKey:pushTokenNew]]) {
            
            [self sendTokenToServer];
        }
    }
}

/**
 *  推送token
 */
- (void)sendTokenToServer {
    
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
//    NSString *url = [NSString stringWithFormat:@"%@deviceToken?userId=%@&deviceToken=%@",tokenURL,[def objectForKey:userNameKey],[def objectForKey:pushTokenNew]];
//    
//    [LJHTTPTool getHTTPWithURL:url params:nil success:^(id responseHTTP) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
}


- (void)setHelloLableText
{
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"凌晨"]) {
        self.helloLable.text = _helloArr[0];
    }
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"早上"]) {
        self.helloLable.text = _helloArr[1];
    }
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"上午"]) {
        self.helloLable.text = _helloArr[2];
    }
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"中午"]) {
        self.helloLable.text = _helloArr[3];
    }
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"下午"]) {
        self.helloLable.text = _helloArr[4];
    }
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"晚上"]) {
        self.helloLable.text = _helloArr[5];
    }
    
}

- (NSString *)getAddress:(NSString *)fileName {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [def objectForKey:USERNAMEKEY];
    
    if (str.length) {
        return [NSString stringWithFormat:@"%@%@",str,fileName];
    } else {
        return @"error";
    }
    
}

- (void)getPhotoAndName
{
//    NSString *filePath = [LJFileTool getFilePath:[self getAddress:selfInfoFileName]];
//    
//    NSFileManager *mgr = [NSFileManager defaultManager];
//    
//    if ([mgr fileExistsAtPath:filePath]) {
//        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
//        
//        self.nameLable.text = [NSString stringWithFormat:@"%@好,%@",[LJTimeTool getCurrentInterval],dict[@"name"]];
//    }else{
//        [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@student/info",sinaURL] params:nil success:^(id responseJSON) {
//            [LJFileTool writeToFileContent:responseJSON withFileName:[self getAddress:selfInfoFileName]];
//            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseJSON];
//            
//            [LJFileTool writeImageToFileName:[self getAddress:selfIconFileName] withImgURL:dict[@"photoUrl"]];
//            
//            self.nameLable.text = [NSString stringWithFormat:@"%@好,%@",[LJTimeTool getCurrentInterval],dict[@"name"]];
//        } failure:^(NSError *error) {
//            [MBProgressHUD showError:errorStr];
//        }];
//    }
}


//判断更新
- (void)isNewest
{
    
//    NSString *app_Version = [LJDeviceTool getCurrentAppVersion];
//    NSString *app_build = [LJDeviceTool getCurrentAppBuild];
//    
//    NSString *requestURL = [NSString stringWithFormat:@"%@version/beta?platform=ios",sinaURL];
//    
//    [LJHTTPTool getJSONWithURL:requestURL params:nil success:^(id responseJSON) {
//        
//        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseJSON];
//        self.dict = dict;
//        NSString *mesg = [NSString stringWithFormat:@"当前版本为 v%@，有更新的版本%@\n\n%@",app_Version,dict[@"name"],dict[@"message"]];
//        
//        NSString *flag = dict[@"build"];
//        
//        if ([app_build intValue] < [flag intValue]) {
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否更新" message:mesg delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"确定", nil];
//            [alert show];
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
}

#pragma mark alert代理
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *url = self.dict[@"shopUrl"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

- (IBAction)logout:(id)sender {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:@"1" forKey:@"flag"];
    [def synchronize];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否退出登录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles: nil];
    [sheet showInView:self.view];
}

- (IBAction)myInfo {
    [self performSegueWithIdentifier:@"main2Info" sender:nil];
}

- (IBAction)mySchedule {
    [self performSegueWithIdentifier:@"main2Schedule" sender:nil];
}

- (IBAction)announce {
    [self performSegueWithIdentifier:@"main2Web" sender:nil];
}

- (IBAction)unpassGrade {
    [self performSegueWithIdentifier:@"main2Unpass" sender:nil];
}

- (IBAction)queryGrade {
    [self performSegueWithIdentifier:@"main2Grade" sender:nil];
}

- (IBAction)examPlan {
    [self performSegueWithIdentifier:@"main2Exam" sender:nil];
}

- (IBAction)skillTest {
    [self performSegueWithIdentifier:@"main2Skill" sender:nil];
}

- (IBAction)donate {
    [self performSegueWithIdentifier:@"main2Donate" sender:nil];
}

#pragma mark ActionSheet代理方法

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) return;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
