//
//  JWCommon.h
//  lntuApp
//
//  Created by JieLee on 14/11/29.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#define sinaURL @"http://lntuonline.sinaapp.com/" // URL
#define tokenURL @"http://eduadm.sinaapp.com/"
#define noticeURL @"http://60.18.131.131:11180/academic/jwgg.jsp"
#define wantedURL @"http://pupboss.com/wanted.html"
#define PUPBOSSURL @"http://blog.pupboss.com"
#define weiboURL @"http://www.weibo.com/yuanjingkeji"
#define storeURL @"https://itunes.apple.com/cn/app/id955004763"

#define waitStr @"正在玩命加载中~~" // 等待提示语
#define errorStr @"服务器被外星人搬走了o(╯□╰)o" // 错误提示语
#define nullStr @"暂无此类数据"
#define LJQQ @"10771533"
#define supportMail @"support@pupboss.com"

#define userNameKey @"userName"
#define pwdKey @"pwd"
#define pushTokenOld @"pushTokenOld"
#define pushTokenNew @"pushTokenNew"
#define selfInfoFileName @"selfInfo.plist"
#define scheduleFileName @"schedule.plist"
#define examPlanFileName @"exam.plist"
#define selfIconFileName @"selfIcon.png"

#define IOS_6 ([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0f)

// 获得RGB颜色
#define LJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
