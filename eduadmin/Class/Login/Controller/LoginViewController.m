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
    
    //标记为刚打开应用
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:@"0" forKey:@"flag"];
    [def synchronize];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if ([[def objectForKey:@"flag"] isEqualToString:@"0"]) {
        if (self.userNameText.text.length) {
            [self login];
        }
    }
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
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if ([def objectForKey:USERNAMEKEY]) {
        
        self.userNameText.text = [def objectForKey:USERNAMEKEY];
        self.pwdText.text = [def objectForKey:PWDKEY];
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
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:self.userNameText.text forKey:USERNAMEKEY];
    [def setObject:self.pwdText.text forKey:PWDKEY];
    [def synchronize];
    
}

- (IBAction)login {
    [self existKeyboard];
    [self recordPwd];
    [MBProgressHUD showMessage:WAITSTR];
    
    NSString *requestURL = [NSString stringWithFormat:@"%@account/login", MAINURL];
    NSDictionary *param = @{@"userId": self.userNameText.text,
                            @"password": self.pwdText.text};

    [LJHTTPTool postJSONWithURL:requestURL params:param loginToken:nil success:^(id responseJSON) {
        
        NSLog(@"=======%@----------------",responseJSON);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"登录成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:ERRORSTR];
    }];
    
}

@end
