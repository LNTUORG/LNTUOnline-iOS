//
//  MBProgressHUD+LJ.h
//  lntuApp
//
//  Created by 李杰 on 14-9-18.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LJ)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
