//
//  JWCommon.h
//  lntuApp
//
//  Created by Li Jie on 14/11/29.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#define MAINURL @"https://api.online.lntu.org/" // 主服务器URL
#define TOKENURL @"http://lntu.applinzi.com/"      // 推送服务器 URL
#define NOTICEURL @"http://60.18.131.131:11180/academic/jwgg.jsp"   // 教务在线公告地址
#define WANTEDURL @"https://www.lntu.org"     // 招募地址
#define PUPBOSSURL @"https://www.pupboss.com"       //  我的网站
#define WEIBOURL @"http://www.weibo.com/yuanjingkeji"
#define STOREURL @"https://itunes.apple.com/cn/app/id955004763"
#define FEEDBACKURL @"https://online.lntu.org/q-a/"

#define WAITSTR @"正在玩命加载中~~" // 等待提示语
#define ERRORSTR @"服务器被外星人搬走了o(╯□╰)o" // 错误提示语
#define NULLSTR @"暂无此类数据"
#define LJQQ @"10771533"
#define SUPPORTMAIL @"hi@pupboss.com"

#define USERNAMEKEY @"userName"   // 用户名 key
#define PWDKEY @"pwd"           // 密码 key

#define PUSHTOKENNEW @"pushTokenNewV2"

#define LOGINTOKEN @"LOGINTOKEN"
#define CLASSTABLEMODE @"ClassTableMode"
#define KNOWOLDCLASSTABLE @"KnowOldClassTable"

#define TOKENFORNET [[NSUserDefaults standardUserDefaults] objectForKey:LOGINTOKEN]

#define selfInfoFileName @"selfInfoV2.plist"
#define scheduleFileName @"scheduleV3.plist"
#define examPlanFileName @"examV2.plist"
#define selfIconFileName @"selfIcon.png"

// 获得RGB颜色
#define LJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
