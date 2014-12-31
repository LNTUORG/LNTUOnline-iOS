//
//  LoginViewController.m
//  eduadmin
//
//  Created by JieLee on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+LJ.h"
#import "LJTools.h"
#import "Common.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self appStart];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.userNameText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdText];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 按钮状态
- (void)textChange
{
    self.loginBtn.enabled = (self.userNameText.text.length && self.pwdText.text.length);
}

// 程序启动
- (void)appStart
{
    
    NSString *filePath = [LJFileTool getFilePath:loginFileName];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        self.userNameText.text = dict[@"userName"];
        self.pwdText.text = dict[@"pwd"];
        self.loginBtn.enabled = YES;
        
    }
}

// 关闭键盘
- (IBAction)existKeyboard {
    [self.view endEditing:YES];
}

// 记住密码
- (void)recordPwd
{
    NSDictionary *dict = @{@"userName": self.userNameText.text,@"pwd": self.pwdText.text};
    
    [LJFileTool writeToFileContent:dict withFileName:loginFileName];
}

- (IBAction)login {
    [self recordPwd];
    [MBProgressHUD showMessage:waitStr];
    
    NSString *requestURL = [NSString stringWithFormat:@"%@user/login",sinaURL];
    NSDictionary *param = @{@"userId": self.userNameText.text,
                            @"pwd": self.pwdText.text,
                            @"platform": @"ios",
                            @"version": [LJDeviceTool getCurrentAppBuild],
                            @"manufacturer": @"Apple",
                            @"osVer": [NSString stringWithFormat:@"iOS%@",[LJDeviceTool getCurrentSystemVersion]],
                            @"model": [LJDeviceTool getCurrentDeviceModel]};
    
    
    [LJHTTPTool postHTTPWithURL:requestURL params:param success:^(id responseHTTP) {
        
        NSString *flag = [[NSString alloc] initWithData:responseHTTP encoding:NSUTF8StringEncoding];
        if ([flag isEqualToString:@"OK"]) {
            
            [self performSegueWithIdentifier:@"loginToIndex" sender:nil];
            
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"登录成功"];
            
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"用户名或密码错误"];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:errorStr];
    }];
    
}

@end
