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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"veins"]];
    [self appStart];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.userNameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
    
}


- (void)textChange {
    
    self.loginButton.enabled = (self.userNameTextField.text.length && self.passwordTextField.text.length);
}

- (void)appStart {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    if ([def objectForKey:USERNAMEKEY]) {
        
        self.userNameTextField.text = [def objectForKey:USERNAMEKEY];
        self.passwordTextField.text = [def objectForKey:PWDKEY];
        self.loginButton.enabled = YES;
    }
}


- (IBAction)forHelpAction:(id)sender {
    
    NSString *url = [NSString stringWithFormat:@"http://wpa.qq.com/msgrd?v=3&uin=%@&site=qq&menu=yes", LJQQ];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (IBAction)existKeyboardAction {
    
    [self.view endEditing:YES];
}


- (void)recordPassword {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:self.userNameTextField.text forKey:USERNAMEKEY];
    [def setObject:self.passwordTextField.text forKey:PWDKEY];
    [def synchronize];
}

- (IBAction)loginAction {
    
    [self existKeyboardAction];
    [self recordPassword];
    [MBProgressHUD showMessage:WAITSTR];
    
    NSString *requestURL = [NSString stringWithFormat:@"%@account/login", MAINURL];
    NSDictionary *param = @{@"userId": self.userNameTextField.text,
                            @"password": self.passwordTextField.text};

    [LJHTTPTool postJSONWithURL:requestURL params:param success:^(id responseJSON) {
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseJSON];
        
        if([dict[@"userType"] isEqualToString:@"STUDENT"]) {
            
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"登录成功"];
            
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
