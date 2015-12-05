//
//  LoginViewController.m
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+LJ.h"
#import "LJTools.h"
#import "Common.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self appStart];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.userNameText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdText];
    
}


- (void)textChange {
    
    self.loginBtn.enabled = (self.userNameText.text.length && self.pwdText.text.length);
}

- (void)appStart {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    if ([def objectForKey:USERNAMEKEY]) {
        
        self.userNameText.text = [def objectForKey:USERNAMEKEY];
        self.pwdText.text = [def objectForKey:PWDKEY];
        self.loginBtn.enabled = YES;
    }
}


- (IBAction)forHelp:(id)sender {
    
    NSString *url = [NSString stringWithFormat:@"http://wpa.qq.com/msgrd?v=3&uin=%@&site=qq&menu=yes", LJQQ];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (IBAction)existKeyboard {
    
    [self.view endEditing:YES];
}


- (void)recordPwd {
    
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

    [LJHTTPTool postJSONWithURL:requestURL params:param success:^(id responseJSON) {
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseJSON];
        
        if([dict[@"userType"] isEqualToString:@"STUDENT"]) {
            
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"登录成功"];
            
            // 保存 token
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            
            [def setObject:dict[@"loginToken"] forKey:LOGINTOKEN];
            [def synchronize];
    
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"暂不支持教师用户"];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
    }];
}

@end
