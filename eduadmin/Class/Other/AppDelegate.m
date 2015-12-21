//
//  AppDelegate.m
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "Common.h"
#import "LJHTTPTool.h"
#import "MainNavigationViewController.h"
#import "PushViewController.h"
#import "LJFileTool.h"
#import "LJTimeTool.h"

@import WatchKit;

@interface AppDelegate () <UIAlertViewDelegate> {
    
    NSMutableArray *_msgs;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 崩溃分析
    [Fabric with:@[CrashlyticsKit]];
    [Fabric with:@[[Crashlytics class]]];

    if (launchOptions) {
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        
        _msgs = [NSMutableArray array];
        
        NSString *msg = launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"][@"aps"][@"alert"];
        [_msgs addObject:msg];
        
        NSString *url = launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"][@"aps"][@"link"];
        
        if (url) {
            
            [_msgs addObject:url];
        }
        
        [self.window.rootViewController performSegueWithIdentifier:@"nav2ab" sender:_msgs];
    }

    
    #ifdef __IPHONE_8_0
    
    if (IOS8) {
        
        UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
        action.identifier = @"action";  //按钮的标示
        action.title=@"查看";  //按钮的标题
        action.activationMode = UIUserNotificationActivationModeForeground;  //当点击的时候启动程序
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2";
        action2.title=@"取消";
        action2.activationMode = UIUserNotificationActivationModeBackground;  //当点击的时候不启动程序，在后台处理
        action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略
        action.destructive = YES;
        
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"alert";//这组动作的唯一标示
        [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    }
    #else
    else {
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    #endif
    
    return YES;
}


- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        // 4
        [application registerForRemoteNotifications];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *getToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    if ([def objectForKey:PUSHTOKENNEW] == nil) {
        
        if (getToken.length && [def objectForKey:USERNAMEKEY] != nil) {
            
            [def setObject:getToken forKey:PUSHTOKENNEW];
            [def synchronize];
            [self sendTokenToServerWithUserId:[def objectForKey:USERNAMEKEY] andToken:getToken];
        }
        
    } else {
        
        if (![[def objectForKey:PUSHTOKENNEW] isEqualToString:getToken]) {
            
            if (getToken.length && [def objectForKey:USERNAMEKEY] != nil) {
                
                [def setObject:getToken forKey:PUSHTOKENNEW];
                [def synchronize];
                [self sendTokenToServerWithUserId:[def objectForKey:USERNAMEKEY] andToken:getToken];
            }
        }
    }
}

- (void)sendTokenToServerWithUserId:(NSString *)userId andToken:(NSString *)deviceToken {
    
    NSDictionary *param = @{@"userId": userId, @"deviceToken": deviceToken};
    
    [LJHTTPTool postJSONWithURL:[NSString stringWithFormat:@"%@device-token/insert", TOKENURL] params:param success:^(id responseJSON) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    _msgs = [NSMutableArray array];
    NSString *msg = userInfo[@"aps"][@"alert"];
    
    [_msgs addObject:msg];
    
    NSString *url = userInfo[@"aps"][@"link"];
    
    if (url) {
        
        [_msgs addObject:url];
    }
    
    if (application.applicationState == UIApplicationStateActive) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新消息" message:_msgs[0] delegate:self cancelButtonTitle:@"我不看" otherButtonTitles:@"好的", nil];
        [alert show];
        
    }else {
        
        [self.window.rootViewController performSegueWithIdentifier:@"nav2ab" sender:_msgs];
    }
}

#pragma mark alert代理
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        [self.window.rootViewController performSegueWithIdentifier:@"nav2ab" sender:_msgs];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
