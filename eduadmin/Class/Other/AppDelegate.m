//
//  AppDelegate.m
//  eduadmin
//
//  Created by JieLee on 14/12/30.
//  Copyright (c) 2014年 JieLee. All rights reserved.
//

#import "AppDelegate.h"
#import <Crashlytics/Crashlytics.h>
#import "Common.h"
#import "LJHTTPTool.h"
#import "MainNavigationViewController.h"
#import "PushViewController.h"
#import "LJFileTool.h"

@interface AppDelegate () <UIAlertViewDelegate>
{
    NSString *_msg;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 崩溃分析
    [Crashlytics startWithAPIKey:@"8feec9fc30497fa73685d17f490a7a7cdad6b2a1"];
    
    if (launchOptions) {
        
        NSString *msg = launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"][@"aps"][@"alert"];
        
        _msg = msg;
        
        [self.window.rootViewController performSegueWithIdentifier:@"nav2ab" sender:_msg];
    }
    
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
        
    }else{
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }

    
    return YES;
}


- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        // 4
        [application registerForRemoteNotifications];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *getToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 从偏好设置读取
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *newToken = [def objectForKey:pushTokenNew];
    if (newToken.length) {
        [def setObject:newToken forKey:pushTokenOld];;
    }
    
    // 写入偏好设置
    [def setObject:getToken forKey:pushTokenNew];
    [def synchronize];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
//    [LJHTTPTool feedbackError:error];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSString *msg = userInfo[@"aps"][@"alert"];
    
    _msg = msg;
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新消息" message:_msg delegate:self cancelButtonTitle:@"我不看" otherButtonTitles:@"好的", nil];
        [alert show];
    }else {
        [self.window.rootViewController performSegueWithIdentifier:@"nav2ab" sender:_msg];
    }
}

#pragma mark alert代理
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        [self.window.rootViewController performSegueWithIdentifier:@"nav2ab" sender:_msg];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
