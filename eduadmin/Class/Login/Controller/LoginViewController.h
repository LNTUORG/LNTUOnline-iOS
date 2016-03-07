//
//  LoginViewController.h
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;


- (IBAction)forHelpAction:(id)sender;

- (IBAction)existKeyboardAction;

- (IBAction)loginAction;

@end
