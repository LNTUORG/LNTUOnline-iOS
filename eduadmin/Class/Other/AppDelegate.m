//
//  AppDelegate.m
//  eduadmin
//
//  Created by JieLee on 14/12/30.
//  Copyright (c) 2014年 JieLee. All rights reserved.
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
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"

@import WatchKit;

@interface AppDelegate () <UIAlertViewDelegate>
{
    NSMutableArray *_msgs;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 崩溃分析
    [Fabric with:@[CrashlyticsKit]];
    
    // 友盟
    [UMSocialData setAppKey:@"55ed5b9067e58e9e910021de"];
    
    [UMSocialQQHandler setQQWithAppId:@"1104773299" appKey:@"ub5xOe0tCnVdOdJY" url:@"http://online.lntu.org/q-a/"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    [UMSocialWechatHandler setWXAppId:@"wx685761e23f9f8a7d" appSecret:@"18cc8223f7456144d48bddae0ba82702" url:@"http://online.lntu.org/q-a/"];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
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
    
    // read from def
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    if ([def objectForKey:PUSHTOKENNEW] == nil) {
        [def setObject:@"0" forKey:HASSENTTOSERVER];
        
        if (getToken.length) {
            // write to def
            [def setObject:getToken forKey:PUSHTOKENNEW];
            [def synchronize];
        }
        
    } else {
        
        if (![[def objectForKey:PUSHTOKENNEW] isEqualToString:getToken]) {
            
            [def setObject:@"0" forKey:HASSENTTOSERVER];
            
            if (getToken.length) {
                // write to def
                [def setObject:getToken forKey:PUSHTOKENNEW];
                [def synchronize];
            }
        }
    }
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
//    [LJHTTPTool feedbackError:error];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
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
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply {
    
    NSInteger day = [LJTimeTool getCurrentWeekDay] - 1;
    if (day == 0) {
        day =7;
    }
    
    NSInteger classNum = [LJTimeTool getCurrentClass];
    
    if (classNum == 6) {
        reply(@{@"course": @"洗洗睡吧~"});
    }
    
    NSString *filePath = [LJFileTool getFilePath:scheduleFileName];
    
    NSString *key = [NSString stringWithFormat:@"%d-%d", (int)day, (int)classNum];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:filePath]) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        NSDictionary *courses = dict[@"courses"];
        
        if (![courses[key] isEqualToString:@""]) {
            NSArray *tempArr = [courses[key] componentsSeparatedByString:@"\n"];
            NSString *course = [NSString stringWithFormat:@"%@\n%@", tempArr[0], tempArr[3]];
            reply(@{@"course": course});
        } else {
            reply(@{@"course": @"下节没课~"});
        }
        
    } else {
        reply(@{@"course": @"error"});
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

@end
