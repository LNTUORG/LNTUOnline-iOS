//
//  LoginViewController.h
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameText;

@property (weak, nonatomic) IBOutlet UITextField *pwdText;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


- (IBAction)forHelp:(id)sender;

- (IBAction)existKeyboard;

- (IBAction)login;

@end
