//
//  JWCommon.h
//  lntuApp
//
//  Created by JieLee on 14/11/29.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#define MAINURL @"http://lntuv2.pupboss.com/api/" // 主服务器URL
#define TOKENURL @"http://eduadm.sinaapp.com/"      // 推送服务器 URL
#define noticeURL @"http://60.18.131.131:11180/academic/jwgg.jsp"   // 教务在线公告地址
#define wantedURL @"http://pupboss.com/2014/12/25/i-want-you/"     // 招募地址
#define PUPBOSSURL @"http://pupboss.com"       //  我的网站
#define weiboURL @"http://www.weibo.com/yuanjingkeji"
#define storeURL @"https://itunes.apple.com/cn/app/id955004763"

#define waitStr @"正在玩命加载中~~" // 等待提示语
#define errorStr @"服务器被外星人搬走了o(╯□╰)o" // 错误提示语
#define nullStr @"暂无此类数据"
#define LJQQ @"10771533"
#define supportMail @"support@pupboss.com"

#define userNameKey @"userName"   // 用户名 key
#define pwdKey @"pwd"           // 密码 key
#define pushTokenOld @"pushTokenOld"  // 旧Token key
#define pushTokenNew @"pushTokenNew"
#define LOGINTOKEN @"LOGINTOKEN"


#define selfInfoFileName @"selfInfo.plist"
#define scheduleFileName @"schedule.plist"
#define examPlanFileName @"exam.plist"
#define selfIconFileName @"selfIcon.png"

// 获得RGB颜色
#define LJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0


#define kStatusBarHeight 64
#define KDevice_Width [[UIScreen mainScreen] bounds].size.width
#define KDevice_Height [[UIScreen mainScreen] bounds].size.height