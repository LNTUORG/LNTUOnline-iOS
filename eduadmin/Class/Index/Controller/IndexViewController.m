//
//  IndexViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "IndexViewController.h"
#import "MBProgressHUD+LJ.h"
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
    // Do any additional setup after loading the view
    _helloArr = @[@"爱生活不爱黑眼圈,快洗洗睡吧",@"一日之计在于晨,上课可别打瞌睡哦",@"坐等下课吃饭去",@"吃个饱饭睡个美容觉,这真是极好的",@"中午养足了精神吗?让我们一起渡过一个愉快的下午茶时间,不过没有茶喝o(╯□╰)o",@"静能生慧.仰观宇宙之大,俯察品类之盛.宇宙之大,每个生命都在孤寂"];
    [self isNewest];
    
#pragma mark scrollView相关
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(0, self.view.frame.size.height - 63);
    [self getPhotoAndName];
    [self setHelloLableText];
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
    
    NSString *filePath = [LJFileTool getFilePath:loginFileName];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        return [NSString stringWithFormat:@"%@%@",dict[@"userName"],fileName];
    }else {
        return @"error";
    }
    
}

- (void)getPhotoAndName
{
    NSString *filePath = [LJFileTool getFilePath:[self getAddress:selfInfoFileName]];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        self.nameLable.text = [NSString stringWithFormat:@"%@好,%@",[LJTimeTool getCurrentInterval],dict[@"name"]];
    }else{
        [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@student/info",sinaURL] params:nil success:^(id responseJSON) {
            [LJFileTool writeToFileContent:responseJSON withFileName:[self getAddress:selfInfoFileName]];
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseJSON];
            
            [LJFileTool writeImageToFileName:[self getAddress:selfIconFileName] withImgURL:dict[@"photoUrl"]];
            
            self.nameLable.text = [NSString stringWithFormat:@"%@好,%@",[LJTimeTool getCurrentInterval],dict[@"name"]];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:errorStr];
        }];
    }
}


//判断更新
- (void)isNewest
{
    
    NSString *app_Version = [LJDeviceTool getCurrentAppVersion];
    NSString *app_build = [LJDeviceTool getCurrentAppBuild];
    
    NSString *requestURL = [NSString stringWithFormat:@"%@version/beta?platform=ios",sinaURL];
    
    [LJHTTPTool getJSONWithURL:requestURL params:nil success:^(id responseJSON) {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseJSON];
        self.dict = dict;
        NSString *mesg = [NSString stringWithFormat:@"当前版本为 v%@，有更新的版本%@\n\n%@",app_Version,dict[@"name"],dict[@"message"]];
        
        NSString *flag = dict[@"build"];
        
        if ([app_build intValue] < [flag intValue]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否更新" message:mesg delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark alert代理
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *url = self.dict[@"shopUrl"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

- (IBAction)logout:(id)sender {
    
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

#pragma mark ActionSheet代理方法

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) return;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
