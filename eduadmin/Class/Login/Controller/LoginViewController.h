//
//  LoginViewController.h
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameText; // 用户名文本框

@property (weak, nonatomic) IBOutlet UITextField *pwdText; // 密码文本框

@property (weak, nonatomic) IBOutlet UIButton *loginBtn; // 登录按钮

- (IBAction)forHelp:(id)sender;

- (IBAction)existKeyboard; // 关闭键盘

- (IBAction)login; //登录事件


@end
